import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import '../../service/Filed.service/Field.service.dart';
import '../../values/app_colors.dart';
import '../../values/app_strings.dart';

import 'dart:convert';
import './Color.dart';
import 'dart:developer';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';
import '../../utils/common_widgets/appbar.dart';
const kGoogleApiKey = "AIzaSyDL9J82iDhcUWdQiuIvBYa0t5asrtz3Swk";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class AddField extends StatefulWidget {
  const AddField({super.key});

  @override
  State<AddField> createState() => MapSampleState();
}

class MapSampleState extends State<AddField> {
  LatLng _center = const LatLng(20.9527494633333, 105.847014555);
  late GoogleMapController mapController;
  final List<LatLng> _points = [];
  final Set<Polygon> _polygons = {};
  final Set<Marker> _markers = {};
  Color stroke_selectedColor = Colors.red;
  Color fill_selectedColor = Colors.red;
  final TextEditingController _stroke_width = TextEditingController(text: '1');
  final TextEditingController _opacity = TextEditingController(text: '0.5');
  final TextEditingController _name = TextEditingController(text: '');
  int stroke_width = 2;
  double opacity = 0.5;
  String name = '';
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng position) {
    final MarkerId markerId = MarkerId(position.toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(
        title: 'Marker',
        snippet: position.toString(),
      ),
      icon: BitmapDescriptor.defaultMarker,
      draggable: true,
      onDragEnd: (LatLng newPosition) {
        _updateMarker(markerId, newPosition);
      },
    );

    setState(() {
      _markers.add(marker);
      _updatePolygon();
    });
  }

  void _updateMarker(MarkerId markerId, LatLng newPosition) {
    setState(() {
      _markers.removeWhere((m) => m.markerId == markerId);
      _markers.add(
        Marker(
          markerId: markerId,
          position: newPosition,
          infoWindow: InfoWindow(
            title: 'Marker',
            snippet: newPosition.toString(),
          ),
          icon: BitmapDescriptor.defaultMarker,
          draggable: true,
          onDragEnd: (LatLng newPosition) {
            _updateMarker(markerId, newPosition);
          },
        ),
      );
      _updatePolygon();
    });
  }

  void _updatePolygon() {
    final String polygonIdVal = 'polygon_id_0';
    _polygons.clear();
    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: _getLatLngFromMarkers(),
        strokeWidth: stroke_width,
        strokeColor: stroke_selectedColor,
        fillColor: fill_selectedColor.withOpacity(opacity),
      ),
    );
  }

  List<LatLng> _getLatLngFromMarkers() {
    return _markers.map((marker) => marker.position).toList();
  }

  List<Map<String, double>> _getLatLngMapFromList() {
    return _getLatLngFromMarkers().map((latLng) {
      return {'lat': latLng.latitude, 'lng': latLng.longitude};
    }).toList();
  }

  String colorToHexString(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  void handleDelete(){
    setState(() {
      _markers.clear();
                        _polygons.clear();
                        _points.clear();
    });
 
  }
  Future<void> handleSave() async {
    if (name.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:const Text('Lỗi'),
            content: const Text('Hãy nhập tên ruộng!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Đóng'),
              ),
            ],
          );
        },
      );
    } else {
      // Thực hiện hành động lưu dữ liệu ở đâyư

      Map<String, dynamic> payload = {
        'coordinate': _getLatLngMapFromList(),
        'strokeColor': colorToHexString(stroke_selectedColor),
        'strokeWidth': stroke_width,
        'name': name,
        'fillColor': colorToHexString(fill_selectedColor),
        'fillOpacity': opacity,
      };
      try {
        final res = await FieldService.addField(payload);
        final status = json.decode(res.body);
        log('resss${status['code']}');
        if (status['code'] == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Thông báo'),
                content: const Text('Tạo ruộng mới thành công!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _markers.clear();
                        _polygons.clear();
                        _points.clear();
                        _stroke_width.clear();
                        _opacity.clear();
                        _name.clear();
                        stroke_selectedColor = Colors.red;
                        fill_selectedColor = Colors.red;
                        stroke_width = 1;
                        opacity = 0.5;
                        name = '';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title:const  Text('Thông báo'),
                content: const Text('Có lỗi xảy ra, xin thử lại!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:const  Text('Đóng'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        log('er: $e');
      }
    }
  }

  Future<void> displayPrediction(Prediction? p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15.0),
        ),
      );
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.addFieldTitle,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 5.0,
            ),
            polygons: _polygons,
            markers: _markers,
            onTap: _onTap,
          ),
          Positioned(
            top: 10,
           
            right: 20,
            child:IconButton(
                    icon: const Icon(Icons.search, color: Colors.white,),
                    onPressed: () async {
                      Prediction? p = await PlacesAutocomplete.show(
                          types: [],
                          offset: 0,
                          radius: 1000,
                          strictbounds: false,
                          region: "vn",
                          mode: Mode.overlay, // Mode.fullscreen
                          language: "vn",
                          components: [Component(Component.country, "vn")],
                          context: context,
                          apiKey: kGoogleApiKey);
                      displayPrediction(p);
                    },
                  ),
                
            ),
          
          if (_getLatLngFromMarkers().isNotEmpty)
            Positioned(
                top: 20.0,
                left: 20.0,
                child: Row(
                  children: [
                    ColorPickerPage(
                      onColorChanged: (color) {
                        setState(() {
                          stroke_selectedColor = color;
                        });
                        _updatePolygon();
                        log('stroke: $color');
                      },
                    ),
                   const  Text('Màu viền')
                  ],
                )),
          if (_getLatLngFromMarkers().isNotEmpty)
            Positioned(
                top: 80.0,
                left: 20.0,
                child: Row(
                  children: [
                    ColorPickerPage(
                      onColorChanged: (color) {
                        log('fill: $color');
                        setState(() {
                          fill_selectedColor = color;
                        });
                        _updatePolygon();
                      },
                    ),
                  const  Text('Màu phủ')
                  ],
                )),
          if (_getLatLngFromMarkers().isNotEmpty)
            Positioned(
              top: 140.0,
              left: 20.0,
              child: SizedBox(
                width: 120,
                child: TextField(
                  controller: _stroke_width,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Độ dày đường',
                  ),
                  onChanged: (value) {
                    log('change: $value');
                    int newValue = int.tryParse(value) ?? stroke_width;
                    _stroke_width.text = value.toString();
                    setState(() {
                      stroke_width = newValue;
                    });
                    _updatePolygon();
                  },
                ),
              ),
            ),
          if (_getLatLngFromMarkers().isNotEmpty)
            Positioned(
              left: 20.0,
              top: 200.0,
              child: SizedBox(
                width: 120,
                child: TextField(
                  controller: _opacity,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Độ trong suốt',
                  ),
                  onChanged: (value) {
                    double newValue = double.tryParse(value) ?? opacity;
                    _opacity.text = value.toString();
                    setState(() {
                      opacity = newValue;
                    });
                    _updatePolygon();
                  },
                  onEditingComplete: () => {},
                ),
              ),
            ),
          if ( _getLatLngFromMarkers().isNotEmpty)
            Positioned(
              top: 260.0,
              left: 20.0,
              child: SizedBox(
                width: 120,
                child: TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tên ruộng',
                  ),
                  onChanged: (value) {
                    _name.text = value.toString();
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ),
            ),
             if (_getLatLngFromMarkers().isNotEmpty)
            Positioned(
              top: 320.0,
              left: 20.0,
              child: SizedBox(
                  width: 120,
                  child: FilledButton(
                      onPressed: () => handleDelete(), child: const Text('Xóa'))),
            ),
          if (_getLatLngFromMarkers().length > 2)
            Positioned(
              top: 380.0,
              left: 20.0,
              child: SizedBox(
                  width: 120,
                  child: FilledButton(
                      onPressed: () => handleSave(), child: const Text('Lưu'))),
            ),
        ],
      ),
    );
  }
}
