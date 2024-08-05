import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'dart:developer';
import 'package:tractorapp/values/app_colors.dart';
import '../../service/Filed.service/Field.service.dart';

final url = dotenv.env['BASE_URL'];

class MapScreen extends StatefulWidget {
  MapScreen(
      {Key? key,
      this.center = 'None',
      this.type = 0,
      required this.onTabChange})
      : super(key: key);
  final String center;
  final int type;
  final Function(String, int) onTabChange;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late double rotate;
  bool _isMounted = false;
  int count = 0;
  late IO.Socket socket;
  late BitmapDescriptor customMarkerIcon;
  LatLng _center = const LatLng(20.9527494633333, 105.847014555);
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  final Set<Polygon> _polygons = {};
  Map<String, List<LatLng>> tractorPoints = {};
  String _value = 'None';
  String _polyvalue = 'None';
  String? selectedTractorId;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<dynamic> _data = [];
  Future<void> _loadData() async {
    final response = await FieldService.getAllField();
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> fields = responseData['data'];
      setState(() {
        _data = fields;
      });
      _createPolygons();
    } else {
      log('Failed to load data: ${response.statusCode}');
    }
  }

  List<LatLng> convertToLatLngList(List coordinates) {
    List<LatLng> latLngList = [];
    for (int i = 0; i < coordinates.length; i += 2) {
      latLngList.add(LatLng(coordinates[i], coordinates[i + 1]));
    }
    return latLngList;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _createPolygons() {
    _polygons.clear();
    Set<Polygon> polygons = {};
    for (var item in _data) {
      List<LatLng> points = [];
      for (var coord in item['coordinate']) {
        points.add(LatLng(coord['lat'], coord['lng']));
      }

      setState(() {
        _polygons.add(
          Polygon(
            polygonId: PolygonId(item['name']),
            points: points,
            strokeColor:
                Color(int.parse(item['strokeColor'].replaceFirst('#', '0xff'))),
            strokeWidth: (item['strokeWidth']),
            fillColor:
                Color(int.parse(item['fillColor'].replaceFirst('#', '0xff')))
                    .withOpacity(item['fillOpacity']),
          ),
        );
      });
    }
  }

  void connect(IO.Socket socket) async {
    try {
      BitmapDescriptor.asset(const ImageConfiguration(size: Size(25, 25)),
              'assets/image/tractor-topview.png')
          .then((d) {
        customMarkerIcon = d;
      });

      if (socket.disconnected) {
        socket.connect();

        socket.on('logs', (data) {
          data.forEach((tractor) {
            final Map<String, dynamic> b = tractor['data'];
            final lat = b['llh'][0];
            final lng = b['llh'][1];
            final rot = b['ypr'][0];
            final List plans = b['plans'];

            final LatLng newPosition = LatLng(lat, lng);

            if (mounted) {
              _markers.removeWhere(
                  (marker) => marker.markerId.value == tractor['tractorName']);
              _polyline.removeWhere((polyline) =>
                  polyline.polylineId.value == 'poly_${tractor['tractorId']}');
              _polyline.removeWhere((polyline) =>
                  polyline.polylineId.value == 'plans_${tractor['tractorId']}');

              setState(() {
                if (!tractorPoints.containsKey(tractor['tractorId'])) {
                  tractorPoints[tractor['tractorId']] = [];
                }
                tractorPoints[tractor['tractorId']]!.add(newPosition);
                rotate = rot.toDouble();
                _markers.add(
                  Marker(
                    markerId: MarkerId(tractor['tractorName']),
                    icon: customMarkerIcon,
                    position: newPosition,
                    rotation: rot.toDouble(),
                  ),
                );

                _polyline.add(
                  Polyline(
                    polylineId: PolylineId('poly_${tractor['tractorId']}'),
                    points: tractorPoints[tractor['tractorId']]!,
                    color: const Color.fromARGB(255, 49, 244, 56),
                    width: 3,
                  ),
                );

                _polyline.add(
                  Polyline(
                    polylineId: PolylineId('plans_${tractor['tractorId']}'),
                    points: convertToLatLngList(plans),
                    color: const Color.fromARGB(255, 36, 21, 235),
                    width: 3,
                  ),
                );
              });
            }
          });
        });
      }
    } catch (e) {
      log('Errors connection: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
    _sprefs.then((prefs) {
      String token = prefs.getString('accesstoken') ?? '';
      //log('token: $token');
      Map<String, String> extraHeaders = {
        'token': token,
      };
      socket = IO.io(url, <String, dynamic>{
        'transports': ['websocket'],
        'force new connection': true,
        'extraHeaders': extraHeaders,
      });

      connect(socket);
      _loadData();
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  void _onDropdownChanged(String? value) {
    if (value != null) {
      _polyvalue = 'None';
      widget.onTabChange(value, 1);
    }
  }

  void _onPolyDropdownChanged(String? value) {
    if (value != null) {
      _value = 'None';
      widget.onTabChange(value, 2);
    }
  }

  Future<void> _refresh() async {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.center != 'None') {
      if (widget.type == 1) {
        _value = widget.center;
        _polyvalue = 'None';
      } else if (widget.type == 2) {
        _value = 'None';
        _polyvalue = widget.center;
        log('valueeee: $_polyvalue');
        Polygon? polygon = _polygons.firstWhere(
          (poly) => poly.polygonId.value == _polyvalue,
          orElse: () => Polygon(
              polygonId:
                  PolygonId('default')), // Trả về null nếu không tìm thấy
        );
        if (polygon.polygonId.value == 'default') {
          _polyvalue = 'None';
        } else {
          _center = polygon.points[0];
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(_center, 17),
          );
        }
      }

      if (_polyvalue != 'None') {
        _value = 'None';
      }
      if (_value != 'None') {
        _polyvalue = 'None';
      }
    } else {
      _value = 'None';
      _polyvalue = 'None';
    }
    if (!(_value == 'None')) {
      Marker? selectedMarker = _markers.firstWhere(
        (marker) => marker.markerId.value == _value,
        // orElse: () => null, // Trả về null nếu không tìm thấy
      );
      _center = selectedMarker.position;
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_center, 25),
      );
    }
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 5.0,
            ),
            markers: _markers,
            polylines: _polyline,
            polygons: _polygons,
          ),
          Positioned(
            top: 20.0,
            left: 20.0,
            child: DropdownButton<String>(
              value: _value,
              style: const TextStyle(color: Color.fromARGB(255, 10, 9, 10)),
              items: [
                ..._markers.map((Marker marker) {
                  return DropdownMenuItem<String>(
                    value: marker.markerId.value.toString(),
                    child: Text(marker.markerId.value.toString()),
                  );
                }),
                const DropdownMenuItem<String>(
                  value: 'None',
                  child: Text('None'),
                ),
              ],
              onChanged: _onDropdownChanged,
              hint: const Text('Select a tractor'),
            ),
          ),
          Positioned(
            top: 20.0,
            right: 20.0,
            child: DropdownButton<String>(
              value: _polyvalue,
              style: const TextStyle(color: Color.fromARGB(255, 10, 9, 10)),
              items: [
                ..._polygons.map((Polygon poly) {
                  log('poly: ${poly.polygonId.value}');
                  return DropdownMenuItem<String>(
                    value: poly.polygonId.value.toString(),
                    child: Text(poly.polygonId.value.toString()),
                  );
                }),
                const DropdownMenuItem<String>(
                  value: 'None',
                  child: Text('None'),
                ),
              ],
              onChanged: _onPolyDropdownChanged,
              hint: const Text('Select a field'),
            ),
          ),
        Positioned(
                  bottom: 10,
                  right: 10,
                  child: FloatingActionButton.extended(
                     heroTag: "btn1",
                    onPressed: () {
                      // Show refresh indicator programmatically on button tap.
                       _refreshIndicatorKey.currentState?.show();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tải lại'),
                  ),
                ), ],
      ),
    );
    /*
     onPressed: () {
        
        },
     */
  }
}
