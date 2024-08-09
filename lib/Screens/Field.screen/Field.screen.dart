import 'package:flutter/material.dart';
import '../../service/Filed.service/Field.service.dart';
import '../../values/app_strings.dart';
import '../../values/app_colors.dart';
import '../../utils/helpers/navigation_helper.dart';
import '../../values/app_routes.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    final item = _data[index];
                    return Padding(
                      padding: const EdgeInsets.all(
                          5.0), 
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 50.0, 
                        ),
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  widget.onTabChange(item['name'] ?? 'None', 2);
                                },
                                child: ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      child: const Icon(
                                        Icons.location_on,
                                        size: 20.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                    title: Text(item['name']),
                                    trailing: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                        child: const Icon(
                                            LineAwesomeIcons.angle_right_solid,
                                            size: 18.0,
                                            color: Colors.grey)
                                            )
                                          )
                                        )
                                  ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: FloatingActionButton.extended(
                    heroTag: "btn2",
                    onPressed: () {
                      NavigationHelper.pushNamed(AppRoutes.add_field);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm ruộng'),
                  ),
                ),
              ],
            )));
    /*
     onPressed: () {
                // Define your action here
             
              },
     */
  }
}
