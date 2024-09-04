import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import '../../service/MQTT.service/mqtt.service.dart';
import 'TractorDetail_chart/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../values/app_strings.dart';
import '../../values/app_colors.dart';

final topic = dotenv.env['MQTT_CHANNEL'] ?? '';

class TrangThai {
  final String label;
  final int value;

  const TrangThai._(this.label, this.value);
  static TrangThai no = TrangThai._('No', 0);
  static TrangThai pause =
      TrangThai._(AppStrings.enum_trangthaimaycay_pause, 1);
  static TrangThai continueDriving =
      TrangThai._(AppStrings.enum_trangthaimaycay_continue, 2);

  static List<TrangThai> get values => [no, pause, continueDriving];
}

class TrangThaiDen {
  final String label;
  final int value;

  const TrangThaiDen._(this.label, this.value);
  static TrangThaiDen no = TrangThaiDen._('No', 0);
  static TrangThaiDen on = TrangThaiDen._(AppStrings.enum_trangthaiden_on, 1);
  static TrangThaiDen off = TrangThaiDen._(AppStrings.enum_trangthaiden_off, 2);

  static List<TrangThaiDen> get values => [no, on, off];
}

class TrangThaiSoPhu {
  final String label;
  final int value;

  const TrangThaiSoPhu._(this.label, this.value);
  static TrangThaiSoPhu no = TrangThaiSoPhu._('No', 0);
  static TrangThaiSoPhu nomal =
      TrangThaiSoPhu._(AppStrings.enum_trangthaisophu_nomal, 1);
  static TrangThaiSoPhu fast =
      TrangThaiSoPhu._(AppStrings.enum_trangthaisophu_fast, 2);

  static List<TrangThaiSoPhu> get values => [no, nomal, fast];
}

class ReserError {
  final String label;
  final int value;

  const ReserError._(this.label, this.value);
  static ReserError no = ReserError._('No', 0);
  static ReserError reset = ReserError._(AppStrings.enum_reseterr_reset, 1);

  static List<ReserError> get values => [no, reset];
}

class MaxRpm {
  final int value;

  const MaxRpm._(this.value);
  static MaxRpm no = MaxRpm._(0);
  static List<MaxRpm> get values {
    List<MaxRpm> rpms = [];
    for (int i = 0; i <= 2700; i += 100) {
      rpms.add(MaxRpm._(i));
    }
    return rpms;
  }
}

class TrangThaiDoNghieng {
  final String label;
  final int value;

  const TrangThaiDoNghieng._(this.label, this.value);
  static TrangThaiDoNghieng no = TrangThaiDoNghieng._('No', 0);
  static TrangThaiDoNghieng nghieng1 =
      TrangThaiDoNghieng._(AppStrings.enum_donghieng_1, 1);
  static TrangThaiDoNghieng nghieng2 =
      TrangThaiDoNghieng._(AppStrings.enum_donghieng_2, 2);

  static TrangThaiDoNghieng nghieng3 =
      TrangThaiDoNghieng._(AppStrings.enum_donghieng_3, 3);

  static List<TrangThaiDoNghieng> get values =>
      [no, nghieng1, nghieng2, nghieng3];
}

class ControlTractor extends StatefulWidget {
  ControlTractor(
      {required this.tractorId,
      required this.token,
      required this.onTabChange,
      required this.tractorName});
  final String tractorId;
  final String? tractorName;
  final String token;
  final Function(String, int) onTabChange;
  @override
  State<ControlTractor> createState() => _StateControlTractor();
}

class _StateControlTractor extends State<ControlTractor> {
  List<int> generateValues(int min,int max,int step) {
    List<int> values = [];
    for (int i = min; i <= max; i += step) {
      values.add(i);
    }
    return values;
  }

  final TextEditingController trang_thai_may_cay_controller =
      TextEditingController();
  final TextEditingController max_rpm_controller = TextEditingController();
  final TextEditingController min_rpm_controller = TextEditingController();
  final TextEditingController trang_thai_tam_de_controller = TextEditingController();
  final TextEditingController trang_thai_so_cang_controller = TextEditingController();
  final TextEditingController trang_thai_den_controller =
      TextEditingController();
  final TextEditingController trang_thai_so_phu_controller =
      TextEditingController();
  final TextEditingController reset_err_controller = TextEditingController();
  final TextEditingController do_nghieng_controller = TextEditingController();
  int trang_thai_max_rpm = 0;
  int trang_thai_min_rpm = 0;
  int trang_thai_so_cang = 0;
  int trang_thai_tam_de = 0;
  int trang_thai_may_cay = 0;
  int trang_thai_den = 0;
  int trang_thai_so_phu = 0;
  int reset_err = 0;
  int do_nghieng = 0;
  final TextEditingController _controller_maxrpm =
      TextEditingController(text: '0');
  final TextEditingController _controller_minrpm =
      TextEditingController(text: '0');
  final TextEditingController _controller_so_cang =
      TextEditingController(text: '0');
  final TextEditingController _controller_tam_de =
      TextEditingController(text: '0');

  final int _min = 0;
  final int _max_rpm = 2700;
  final int _max_so_cang = 49;
  final int input_trangthaimay = 0;
  final int input_maxrpm = 1;
  final int input_minrpm = 2;
  final int input_socang = 3;
  final int input_tamde = 4;
  final int input_trangthaiden = 5;
  final int input_trangthaisophu = 6;
  final int input_reseterr = 7;
  final int input_donghieng = 8;

  final MQTTService mqttService = MQTTService();

  @override
  void initState() {
    super.initState();
    mqttService.connect();
  }

  void Xu_ly_input(int loai_input, value) {
    if (loai_input == input_trangthaimay) {
      setState(() {
        trang_thai_may_cay = value;
      });
    } else if (loai_input == input_maxrpm) {
      log('value: $value');
      setState(() {
        trang_thai_max_rpm = value;
      });
    } else if (loai_input == input_minrpm) {
      setState(() {
        trang_thai_min_rpm = value;
      });
    } else if (loai_input == input_socang) {
      setState(() {
        trang_thai_so_cang = value;
      });
    } else if (loai_input == input_tamde) {
      setState(() {
        trang_thai_tam_de = value;
      });
    } else if (loai_input == input_trangthaiden) {
      setState(() {
        trang_thai_den = value;
      });
    } else if (loai_input == input_trangthaisophu) {
      setState(() {
        trang_thai_so_phu = value;
      });
    } else if (loai_input == input_reseterr) {
      setState(() {
        reset_err = value;
      });
    } else if (loai_input == input_donghieng) {
      setState(() {
        do_nghieng = value;
      });
    }

    final String string = '{"data":{   "reset_er_c":"' +
        reset_err.toString() +
        '" ,"min_rpm_c":"' +
        trang_thai_min_rpm.toString() +
        '" ,"max_rpm_c":"' +
        trang_thai_max_rpm.toString() +
        '" ,"mode_run_c":"' +
        trang_thai_may_cay.toString() +
        '" ,"so_cang_max":"' +
        trang_thai_so_cang.toString() +
        '" ,"tam_de":"' +
        trang_thai_tam_de.toString() +
        '" ,"nghieng":"' +
        do_nghieng.toString() +
        '" ,"led1":"' +
        trang_thai_den.toString() +
        '" ,"phumax":"' +
        trang_thai_so_phu.toString() +
        '"  }}';
    mqttService.publish(
      topic,
      string,
    );
    log('bbb: $string');
  }

  @override
  Widget build(BuildContext context) {
    MaxRpm? selectedRpm = MaxRpm.values[0];
    log('tttttt: ${selectedRpm.value}');
    List<int> rpm = generateValues(0, 2700, 100);
    List<int> so_cang = generateValues(0, 49, 1);
    List<int> tam_de = generateValues(0, 49, 1);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownMenu<TrangThai>(
              width: 100,
              initialSelection: TrangThai.no,
              controller: trang_thai_may_cay_controller,
              requestFocusOnTap: false,
              textStyle: const TextStyle(color: AppColors.text_dark),
              label: Text(AppStrings.tractor_state_state,
                  style: TextStyle(color: AppColors.text_dark)),
              onSelected: (TrangThai? trangthai) {
                Xu_ly_input(input_trangthaimay, trangthai?.value);
              },
              dropdownMenuEntries: TrangThai.values
                  .map<DropdownMenuEntry<TrangThai>>((TrangThai trangthai) {
                return DropdownMenuEntry<TrangThai>(
                  value: trangthai,
                  label: trangthai.label,
                );
              }).toList(),
            ),
            DropdownMenu<int>(
              menuHeight: 200,
              width: 100,
              initialSelection: rpm[0],
              controller: max_rpm_controller,
              requestFocusOnTap: false,
              textStyle: const TextStyle(color: AppColors.text_dark),
              label: Text(AppStrings.tractor_state_maxrpm,
                  style: TextStyle(color: AppColors.text_dark)),
              onSelected: (int? max_rpm) {
                Xu_ly_input(input_maxrpm, max_rpm);
              },
              dropdownMenuEntries:
                  rpm.map<DropdownMenuEntry<int>>((int maxrpm) {
                return DropdownMenuEntry<int>(
                  value: maxrpm,
                  label: maxrpm.toString(),
                );
              }).toList(),
            ),


              DropdownMenu<int>(
              menuHeight: 200,
              width: 100,
              initialSelection: rpm[0],
              controller: min_rpm_controller,
              requestFocusOnTap: false,
              textStyle: const TextStyle(color: AppColors.text_dark),
              label: Text(AppStrings.tractor_state_minrpm,
                  style: TextStyle(color: AppColors.text_dark)),
              onSelected: (int? min_rpm) {
                Xu_ly_input(input_minrpm, min_rpm);
              },
              dropdownMenuEntries:
                  rpm.map<DropdownMenuEntry<int>>((int minrpm) {
                return DropdownMenuEntry<int>(
                  value: minrpm,
                  label: minrpm.toString(),
                );
              }).toList(),
            ),


            /*
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controller_maxrpm,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Max rpm',
                ),
                onEditingComplete: () =>
                    Xu_ly_input(input_maxrpm, trang_thai_max_rpm),
                onChanged: (value) {
                  int newValue = int.tryParse(value) ?? _min;
                  if (newValue < _min) {
                    newValue = _min;
                    _controller_maxrpm.text = newValue.toString();
                  } else if (newValue > _max_rpm) {
                    newValue = _max_rpm;
                    _controller_maxrpm.text = newValue.toString();
                  }
                  setState(() {
                    trang_thai_max_rpm = newValue;
                  });
                },
              ),
            ),
            */
            /*
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controller_minrpm,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Min rpm',
                ),
                onChanged: (value) {
                  int newValue = int.tryParse(value) ?? _min;
                  if (newValue < _min) {
                    newValue = _min;
                    _controller_minrpm.text = newValue.toString();
                  } else if (newValue > _max_rpm) {
                    newValue = _max_rpm;
                    _controller_minrpm.text = newValue.toString();
                  }
                  setState(() {
                    trang_thai_min_rpm = newValue;
                  });
                },
                onEditingComplete: () =>
                    Xu_ly_input(input_minrpm, trang_thai_min_rpm),
              ),
            ),
            */
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              DropdownMenu<int>(
              menuHeight: 200,
              width: 100,
              initialSelection: tam_de[0],
              controller: trang_thai_tam_de_controller,
              requestFocusOnTap: false,
              textStyle: const TextStyle(color: AppColors.text_dark),
              label: Text(AppStrings.tractor_state_tam_de,
                  style: TextStyle(color: AppColors.text_dark)),
              onSelected: (int? tam_de) {
                Xu_ly_input(input_tamde, tam_de);
              },
              dropdownMenuEntries:
                  tam_de.map<DropdownMenuEntry<int>>((int tamde) {
                return DropdownMenuEntry<int>(
                  value: tamde,
                  label: tamde.toString(),
                );
              }).toList(),
            ),
            DropdownMenu<int>(
              menuHeight: 200,
              width: 100,
              initialSelection: so_cang[0],
              controller: trang_thai_so_cang_controller,
              requestFocusOnTap: false,
              textStyle: const TextStyle(color: AppColors.text_dark),
              label: Text(AppStrings.tractor_state_so_cang,
                  style: TextStyle(color: AppColors.text_dark)),
              onSelected: (int? so_cang) {
                Xu_ly_input(input_socang, so_cang);
              },
              dropdownMenuEntries:
                so_cang.map<DropdownMenuEntry<int>>((int socang) {
                return DropdownMenuEntry<int>(
                  value: socang,
                  label: socang.toString(),
                );
              }).toList(),
            ),
            /*
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controller_so_cang,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Số càng',
                ),
                onChanged: (value) {
                  int newValue = int.tryParse(value) ?? _min;
                  if (newValue < _min) {
                    newValue = _min;
                    _controller_so_cang.text = newValue.toString();
                  } else if (newValue > _max_so_cang) {
                    newValue = _max_so_cang;
                    _controller_so_cang.text = newValue.toString();
                  }
                  setState(() {
                    trang_thai_so_cang = newValue;
                  });
                },
                onEditingComplete: () =>
                    Xu_ly_input(input_socang, trang_thai_so_cang),
              ),
            ),
            */
            /*
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controller_tam_de,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tấm dè',
                ),
                onChanged: (value) {
                  int newValue = int.tryParse(value) ?? _min;
                  if (newValue < _min) {
                    newValue = _min;
                    _controller_tam_de.text = newValue.toString();
                  } else if (newValue > _max_so_cang) {
                    newValue = _max_so_cang;
                    _controller_tam_de.text = newValue.toString();
                  }
                  setState(() {
                    trang_thai_tam_de = newValue;
                  });
                },
                onEditingComplete: () =>
                    Xu_ly_input(input_tamde, trang_thai_tam_de),
              ),
            ),
            */
            DropdownMenu<TrangThaiDen>(
              width: 100,
              initialSelection: TrangThaiDen.no,
              controller: trang_thai_den_controller,
              requestFocusOnTap: false,
              textStyle: const TextStyle(color: AppColors.text_dark),
              label: Text(AppStrings.tractor_state_light,
                  style: TextStyle(color: AppColors.text_dark)),
              onSelected: (TrangThaiDen? trangthai) {
                Xu_ly_input(input_trangthaiden, trangthai?.value);
              },
              dropdownMenuEntries: TrangThaiDen.values
                  .map<DropdownMenuEntry<TrangThaiDen>>(
                      (TrangThaiDen trangthai) {
                return DropdownMenuEntry<TrangThaiDen>(
                  value: trangthai,
                  label: trangthai.label,
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownMenu<TrangThaiSoPhu>(
              width: 100,
              initialSelection: TrangThaiSoPhu.no,
              controller: trang_thai_so_phu_controller,
              requestFocusOnTap: false,
              textStyle: const TextStyle(color: AppColors.text_dark),
              label: Text(AppStrings.tractor_state_so_phu,
                  style: TextStyle(color: AppColors.text_dark)),
              onSelected: (TrangThaiSoPhu? trangthai) {
                Xu_ly_input(input_trangthaisophu, trangthai?.value);
              },
              dropdownMenuEntries: TrangThaiSoPhu.values
                  .map<DropdownMenuEntry<TrangThaiSoPhu>>(
                      (TrangThaiSoPhu trangthai) {
                return DropdownMenuEntry<TrangThaiSoPhu>(
                  value: trangthai,
                  label: trangthai.label,
                );
              }).toList(),
            ),
            DropdownMenu<ReserError>(
              width: 100,
              initialSelection: ReserError.no,
              controller: reset_err_controller,
              requestFocusOnTap: false,
              textStyle: const TextStyle(color: AppColors.text_dark),
              label: Text(AppStrings.tractor_state_reseterr,
                  style: TextStyle(color: AppColors.text_dark)),
              onSelected: (ReserError? trangthai) {
                Xu_ly_input(input_reseterr, trangthai?.value);
              },
              dropdownMenuEntries: ReserError.values
                  .map<DropdownMenuEntry<ReserError>>((ReserError trangthai) {
                return DropdownMenuEntry<ReserError>(
                  value: trangthai,
                  label: trangthai.label,
                );
              }).toList(),
            ),
            DropdownMenu<TrangThaiDoNghieng>(
              width: 100,
              initialSelection: TrangThaiDoNghieng.no,
              controller: do_nghieng_controller,
              requestFocusOnTap: false,
              textStyle: const TextStyle(color: AppColors.text_dark),
              label: Text(AppStrings.tractor_state_do_nghieng,
                  style: TextStyle(color: AppColors.text_dark)),
              onSelected: (TrangThaiDoNghieng? trangthai) {
                Xu_ly_input(input_reseterr, trangthai?.value);
              },
              dropdownMenuEntries: TrangThaiDoNghieng.values
                  .map<DropdownMenuEntry<TrangThaiDoNghieng>>(
                      (TrangThaiDoNghieng trangthai) {
                return DropdownMenuEntry<TrangThaiDoNghieng>(
                  value: trangthai,
                  label: trangthai.label,
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TractorDetailChart(
                              tractorId: widget.tractorId,
                              token: widget.token,
                              tractorName: widget.tractorName ?? 'Tractor',
                            )),
                  );
                },
                child: const Text(
                  'Xem chi tiết',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  widget.onTabChange(widget.tractorName ?? 'None', 1);
                },
                child: const Text('Xem trên bản đồ',
                    style: TextStyle(fontSize: 14)),
              ),
            )
          ],
        )
      ],
    );
  }
}
