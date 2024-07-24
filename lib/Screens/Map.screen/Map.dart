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

  List<dynamic> _data = [];
  Future<void> _loadData() async {
    final response = await FieldService.getAllField();
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> fields = responseData['data'];
      log('Response data: ${fields.length}');
      setState(() {
        _data = fields;
        
      });
      log('legth ${_data.length}');
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
    Set<Polygon> polygons = {};
    for (var item in _data) {
      log('name1: ${item['name']}');
      List<LatLng> points = [];
      for (var coord in item['coordinate']) {
        points.add(LatLng(coord['lat'], coord['lng']));
      }
      log('ssssssssss:${points.length}');
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
          log('onnnn');
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
// Xóa các Polyline có polylineId bằng một giá trị cụ thể
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
    log('rerender');
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
    socket.onDisconnect((_) {
      log('Disconnected from the socket server');
    });
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  void _onDropdownChanged(String? value) {
    if (value != null) {
      // Tìm marker theo value (ví dụ: 'tractorId_1')
      _polyvalue = 'None';
      widget.onTabChange(value, 1);
    }
  }

  void _onPolyDropdownChanged(String? value) {
    if (value != null) {
    //  _polyvalue = value;
      _value = 'None';
      log('poly: ${_polyvalue}');
      widget.onTabChange(value, 2);
      // Tìm marker theo value (ví dụ: 'tractorId_1')
     
      // widget.onTabChange(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    log('rerender');
    if (widget.center != 'None') {
      if (widget.type == 1) {
        log('bbbbbbbb');
        _value = widget.center;
          _polyvalue = 'None';
      } else if (widget.type == 2) {
        log('ccccccc');
         _value = 'None';
        _polyvalue = widget.center;
         Polygon? polygon = _polygons.firstWhere(
          (poly) => poly.polygonId.value == _polyvalue,
          // orElse: () => null, // Trả về null nếu không tìm thấy
        );
        _center = polygon.points[0];
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(_center, 17),
        );
      }

      if (_polyvalue != 'None') {
        _value = 'None';
      }
      if (_value != 'None') {
        _polyvalue = 'None';
      }
    } else {
      log('ddddd');
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
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: true,
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
                  // log('ida: ${poly.polygonId.value.toString()}');
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
        ],
      ),
    );
  }
}




 
