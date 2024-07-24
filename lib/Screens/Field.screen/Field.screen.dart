import 'package:flutter/material.dart';
import '../../service/Filed.service/Field.service.dart';
import '../../values/app_strings.dart';
import '../../values/app_colors.dart';
import '../../utils/helpers/navigation_helper.dart';
import '../../values/app_routes.dart';
import 'dart:developer';
import 'dart:convert';

class Fields extends StatefulWidget {
  final Function(String, int) onTabChange;

  const Fields({Key? key, required this.onTabChange}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Fields();
}

class _Fields extends State<Fields> {
  List<dynamic> _data = [];
  Future<void> _loadData() async {
    final response = await FieldService.getAllField();
    log('res:${response.statusCode}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> fields = responseData['data'];
      log('Response data: ${fields}');
      setState(() {
        _data = fields;
      });
    } else {
      log('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: const Text(
          AppStrings.FieldTitle,
          style: TextStyle(
              color: Colors.grey, // Set the text color here
              fontSize: 24.0, // Set the font size here
              fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
    Padding(
      padding: const EdgeInsets.only(right: 16.0), // Adjust the padding value as needed
      child: IconButton(
        icon: const Icon(Icons.add, color: Colors.grey),
        onPressed: () {
          // Define your action here
NavigationHelper.pushNamed(AppRoutes.add_field);
        },
      ),
    ),
  ],
      ),
      backgroundColor: AppColors.bodyColor,
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          final item = _data[index];
          return Padding(
            padding: const EdgeInsets.all(
                5.0), // Increase vertical padding for more spacing
            child: Container(
                constraints: const BoxConstraints(
                  minHeight: 50.0, // Minimum height is 50 units
                ),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 0.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Màu của bóng đổ
                      spreadRadius: 1, // Độ rộng bóng đổ
                      blurRadius: 5, // Độ mờ của bóng đổ
                      offset: Offset(0, 3), // Vị trí bóng đổ (x, y)
                    ),
                  ], // Optional: to give rounded corners
                ),
                child: ListTile(
                  title: Text(item['name']),
                  trailing: InkWell(
                    onTap: () {
                      widget.onTabChange(item['name'] ?? 'None', 2);
                    },
                    child: const Icon(
                      Icons.location_on,
                      size: 20.0,
                      color: Colors.red,
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
