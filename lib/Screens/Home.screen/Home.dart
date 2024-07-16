import 'package:flutter/material.dart';
import '../../values/app_colors.dart';
import '../../values/app_strings.dart';
import 'Float-button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: const Text(
          AppStrings.homeTitleAppbarr,
          style: TextStyle(
              color: Colors.grey, // Set the text color here
              fontSize: 24.0, // Set the font size here
              fontWeight: FontWeight.normal),
        ),
      ),
      backgroundColor: AppColors.bodyColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    print('Card tapped!');
                  },
                ),
                FloatButton(
                  size: size,
                  color: Colors.amber,
                  icon: Icon(Icons.lightbulb_outline, color: Colors.white),
                  title: 'Lights',
                  subtitle: '8 Devices',
                  onTap: () {
                    print('Card tapped!');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatButton(
                  size: size,
                  color: Colors.orange,
                  icon: Icon(Icons.music_note_outlined, color: Colors.white),
                  title: 'Speakers',
                  subtitle: '2 Devices',
                  onTap: () {
                    print('Card tapped!');
                  },
                ),
                FloatButton(
                  size: size,
                  color: Colors.teal,
                  icon: Icon(Icons.sports_cricket_sharp, color: Colors.white),
                  title: 'Cricket bat',
                  subtitle: '8 Devices',
                  onTap: () {
                    print('Card tapped!');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatButton(
                  size: size,
                  color: Colors.purple,
                  icon: Icon(Icons.wifi_outlined, color: Colors.white),
                  title: 'Sensors',
                  subtitle: '5 Devices',
                  onTap: () {
                    print('Card tapped!');
                  },
                ),
                FloatButton(
                  size: size,
                  color: Colors.green,
                  icon: Icon(Icons.air_outlined, color: Colors.white),
                  title: 'Air Condition',
                  subtitle: '4 Devices',
                  onTap: () {
                    print('Card tapped!');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );

    // TODO: implement build
    throw UnimplementedError();
  }
}
