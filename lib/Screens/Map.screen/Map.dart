import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'dart:developer';

import 'package:tractorapp/values/app_colors.dart';


class MapScreen extends StatefulWidget {
 
  const MapScreen({Key? key, this.center='None',required this.onTabChange}) : super(key: key);
  final String center;
  final Function(String) onTabChange;
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
  Map<String, List<LatLng>> tractorPoints = {};
   String _value = 'None';
 String? selectedTractorId;
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

  void connect(IO.Socket socket) async {
    try {
       BitmapDescriptor.asset(ImageConfiguration(size: Size(25, 25)),
            'assets/image/tractor-topview.png')
        .then((d) {
      customMarkerIcon = d;
    });

    if (socket.disconnected) {
      print('before: ${socket.disconnected}');

      socket.onConnect((_) {
        print('connected');
      });
      socket.connect();

      print('after: ${socket.disconnected}');
      socket.on('logs', (data) {

        data.forEach((tractor) {

          final Map<String, dynamic> b = tractor['data'];
          final lat = b['llh'][0];
          final lng = b['llh'][1];
          final rot = b['ypr'][0];
          final List plans = b['plans'];

          final LatLng newPosition = LatLng(lat, lng);
          if (!tractorPoints.containsKey(tractor['tractorId'])) {
            tractorPoints[tractor['tractorId']] = [];
          }
          tractorPoints[tractor['tractorId']]!.add(newPosition);

          if (mounted) {
            _markers.removeWhere((marker) => marker.markerId.value == tractor['tractorName']);

// Xóa các Polyline có polylineId bằng một giá trị cụ thể
_polyline.removeWhere((polyline) => polyline.polylineId.value == 'poly_${tractor['tractorId']}');
_polyline.removeWhere((polyline) => polyline.polylineId.value == 'plans_${tractor['tractorId']}');

            setState(() {
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
                  color: Color.fromARGB(255, 49, 244, 56),
                  width: 3,
                ),
              );

              _polyline.add(
                Polyline(
                  polylineId: PolylineId('plans_${tractor['tractorId']}'),
                  points: convertToLatLngList(plans),
                  color: Color.fromARGB(255, 36, 21, 235),
                  width: 3,
                ),
              );
              if(widget.center !='None'){
                _value = widget.center ;
               
              }else{
                _value= 'None';
              }
              if(!(_value=='None') ){
 Marker? selectedMarker = _markers.firstWhere(
      (marker) => marker.markerId.value == _value,
     // orElse: () => null, // Trả về null nếu không tìm thấy
    );
    _center = selectedMarker.position;
     mapController.animateCamera(
      
        CameraUpdate.newLatLngZoom(_center,25),
      );
              }
            });
          }
        });
      });
    }
    } catch (e) {
      
    }

    
   
  }

  @override
  void initState() {
    super.initState();
     log('rerender');
    Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
    _sprefs.then((prefs) {
      String token = prefs.getString('accesstoken') ?? '';
     
      Map<String, String> extraHeaders = {
        'token': token,
      };
      socket = IO.io('http://tractorserver.myddns.me:3001', <String, dynamic>{
        'transports': ['websocket'],
        'force new connection': true,
        'extraHeaders': extraHeaders,
      });

      connect(socket);
    });
  }
  @override
  void dispose() {
    socket.onDisconnect((_) {
      print('Disconnected from the socket server');
    });
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
 void _onDropdownChanged(String? value) {
  if (value != null) {
    // Tìm marker theo value (ví dụ: 'tractorId_1')
   

      widget.onTabChange(value);
     

     
    
  }
}


  @override
   Widget build(BuildContext context) {
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
    DropdownMenuItem<String>(
      value: 'None',
      child: Text('None'),
    ),
  ],
              onChanged: _onDropdownChanged,
              
              hint: Text('Select a tractor'),
            ),
          ),
        ],
      ),
    );
  }
}
