import 'package:flutter/material.dart';
import '../../values/app_colors.dart';
import '../../values/app_strings.dart';
import 'Float-button.dart';
import '../../service/firebase.service/firebase.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatButton(
                size: size,
                color: Colors.blue,
                icon: const Icon(
                  Icons.camera_outlined,
                  color: Colors.white,
                ),
                title: 'Cameras',
                subtitle: '8 Devices',
                onTap: () {
                },
              ),
              FloatButton(
                size: size,
                color: Colors.amber,
                icon: const Icon(Icons.lightbulb_outline, color: Colors.white),
                title: 'Lights',
                subtitle: '8 Devices',
                onTap: () {
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatButton(
                size: size,
                color: Colors.orange,
                icon:
                    const Icon(Icons.music_note_outlined, color: Colors.white),
                title: 'Speakers',
                subtitle: '2 Devices',
                onTap: () {
                },
              ),
              FloatButton(
                size: size,
                color: Colors.teal,
                icon:
                    const Icon(Icons.sports_cricket_sharp, color: Colors.white),
                title: 'Cricket bat',
                subtitle: '8 Devices',
                onTap: () {
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatButton(
                size: size,
                color: Colors.purple,
                icon: const Icon(Icons.wifi_outlined, color: Colors.white),
                title: 'Sensors',
                subtitle: '5 Devices',
                onTap: () {
                },
              ),
              FloatButton(
                size: size,
                color: Colors.green,
                icon: const Icon(Icons.air_outlined, color: Colors.white),
                title: 'Air Condition',
                subtitle: '4 Devices',
                onTap: () {
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
