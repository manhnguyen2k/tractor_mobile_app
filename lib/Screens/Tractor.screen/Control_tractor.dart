import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import '../../service/MQTT.service/mqtt.service.dart';
import 'TractorDetail/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final topic = dotenv.env['MQTT_CHANNEL'] ?? '';

enum Trang_thai_may_cay {
  _pause('Dừng lại', 0),
  _continue('Đi tiếp', 1);

  const Trang_thai_may_cay(this.label, this.value);
  final String label;
  final int value;
}

enum Trang_thai_den {
  _off('Tắt', 0),
  _on('Bật', 1);

  const Trang_thai_den(this.label, this.value);
  final String label;
  final int value;
}

enum Trang_thai_so_phu {
  _no('NO', 0),
  _normal('Bình thường', 1),
  _fast('Nhanh', 2);

  const Trang_thai_so_phu(this.label, this.value);
  final String label;
  final int value;
}

enum Reset_err {
  _no('NO', 0),
  _reset('Reset', 1);

  const Reset_err(this.label, this.value);
  final String label;
  final int value;
}

enum Do_nghieng {
  _no('NO', 0),
  _1_truc('Nghiêng 1 trục', 1),
  _2_truc('Nghiêng 2 trục', 2),
  _3_truc('Nghiêng 3 trục', 3);

  const Do_nghieng(this.label, this.value);
  final String label;
  final int value;
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
  final TextEditingController trang_thai_may_cay_controller =
      TextEditingController();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownMenu<Trang_thai_may_cay>(
              width: 120,
              initialSelection: Trang_thai_may_cay._pause,
              controller: trang_thai_may_cay_controller,
              requestFocusOnTap: true,
              label: const Text('Trạng thái'),
              onSelected: (Trang_thai_may_cay? trangthai) {
                Xu_ly_input(input_trangthaimay, trangthai?.value);
                ;
              },
              dropdownMenuEntries: Trang_thai_may_cay.values
                  .map<DropdownMenuEntry<Trang_thai_may_cay>>(
                      (Trang_thai_may_cay trangthai) {
                return DropdownMenuEntry<Trang_thai_may_cay>(
                  value: trangthai,
                  label: trangthai.label,
                );
              }).toList(),
            ),
            SizedBox(
              width: 120,
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
            SizedBox(
              width: 120,
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
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
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
            SizedBox(
              width: 120,
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
            DropdownMenu<Trang_thai_den>(
              width: 120,
              initialSelection: Trang_thai_den._off,
              controller: trang_thai_den_controller,
              requestFocusOnTap: true,
              label: const Text('Đèn'),
              onSelected: (Trang_thai_den? trangthai) {
                Xu_ly_input(input_trangthaiden, trangthai?.value);
              },
              dropdownMenuEntries: Trang_thai_den.values
                  .map<DropdownMenuEntry<Trang_thai_den>>(
                      (Trang_thai_den trangthai) {
                return DropdownMenuEntry<Trang_thai_den>(
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
            DropdownMenu<Trang_thai_so_phu>(
              width: 120,
              initialSelection: Trang_thai_so_phu._no,
              controller: trang_thai_so_phu_controller,
              requestFocusOnTap: true,
              label: const Text('Số phụ'),
              onSelected: (Trang_thai_so_phu? trangthai) {
                Xu_ly_input(input_trangthaisophu, trangthai?.value);
              },
              dropdownMenuEntries: Trang_thai_so_phu.values
                  .map<DropdownMenuEntry<Trang_thai_so_phu>>(
                      (Trang_thai_so_phu trangthai) {
                return DropdownMenuEntry<Trang_thai_so_phu>(
                  value: trangthai,
                  label: trangthai.label,
                  //enabled: trangthai.label != 'Grey',
                );
              }).toList(),
            ),
            DropdownMenu<Reset_err>(
              width: 120,
              initialSelection: Reset_err._no,
              controller: reset_err_controller,
              requestFocusOnTap: true,
              label: const Text('Reset Error'),
              onSelected: (Reset_err? trangthai) {
                Xu_ly_input(input_reseterr, trangthai?.value);
              },
              dropdownMenuEntries: Reset_err.values
                  .map<DropdownMenuEntry<Reset_err>>((Reset_err trangthai) {
                return DropdownMenuEntry<Reset_err>(
                  value: trangthai,
                  label: trangthai.label,
                );
              }).toList(),
            ),
            DropdownMenu<Do_nghieng>(
              width: 120,
              initialSelection: Do_nghieng._no,
              controller: do_nghieng_controller,
              requestFocusOnTap: true,
              label: const Text('Độ nghiêng'),
              onSelected: (Do_nghieng? trangthai) {
                Xu_ly_input(input_donghieng, trangthai?.value);
              },
              dropdownMenuEntries: Do_nghieng.values
                  .map<DropdownMenuEntry<Do_nghieng>>((Do_nghieng trangthai) {
                return DropdownMenuEntry<Do_nghieng>(
                  value: trangthai,
                  label: trangthai.label,
                  //enabled: trangthai.label != 'Grey',
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
              child: FilledButton(
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
              child: FilledButton(
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
