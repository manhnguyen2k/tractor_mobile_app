import 'package:flutter/material.dart';
import './youtube.srteam.dart';
import 'package:flutter/services.dart';
import '../../../../values/app_colors.dart';
import 'dart:developer';
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

class ControlOnlineTractor extends StatefulWidget {
  @override
  State<ControlOnlineTractor> createState() => _StateControl();
}

class _StateControl extends State<ControlOnlineTractor> {
  final TextEditingController trang_thai_may_cay_controller =
      TextEditingController();
  final TextEditingController trang_thai_den_controller =
      TextEditingController();
  final TextEditingController trang_thai_so_phu_controller =
      TextEditingController();
  final TextEditingController reset_err_controller = TextEditingController();
  final TextEditingController do_nghieng_controller = TextEditingController();
  //final TextEditingController _videoId = TextEditingController();
  String _videoId = '';
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
final TextEditingController _controller_videoId =
      TextEditingController(text: '');
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
   String videoId = '5M4fQLdlKgA';
  
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
  }

void doi_video(value){
  log('aaaaaaa$value');
    setState(() {
      videoId = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YouTubePlayerScreen(videoId: videoId,),
        Positioned(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownMenu<Trang_thai_may_cay>(
                    width: 100,
                    initialSelection: Trang_thai_may_cay._pause,
                    controller: trang_thai_may_cay_controller,
                    requestFocusOnTap: true,
                    textStyle: const TextStyle(color: AppColors.text_dark),
                 
                    label: const Text('Trạng thái', style: TextStyle(color: AppColors.text_dark),),
                    onSelected: (Trang_thai_may_cay? trangthai) {
                      Xu_ly_input(input_trangthaimay, trangthai?.value);
                      
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
                    width: 100,
                    child: TextField(
                      style: const TextStyle(color: AppColors.text_dark),
                      controller: _controller_maxrpm,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(

                        ),
                        labelText: 'Max rpm',
                      //  hintStyle: TextStyle(color: AppColors.textColor)
                        
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
                    width: 100,
                    child: TextField(
                      controller: _controller_minrpm,
                      keyboardType: TextInputType.number,
                         style: const TextStyle(color: AppColors.text_dark),
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
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _controller_so_cang,
                         style: const TextStyle(color: AppColors.text_dark),
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
                    width: 100,
                    child: TextField(
                      controller: _controller_tam_de,
                      keyboardType: TextInputType.number,
                         style: const TextStyle(color: AppColors.text_dark),
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
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0, left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownMenu<Trang_thai_den>(
              width: 100,
              textStyle:   const TextStyle(color: AppColors.text_dark),
              initialSelection: Trang_thai_den._off,
              controller: trang_thai_den_controller,
              requestFocusOnTap: true,
              label: const Text('Đèn',    style: TextStyle(color: AppColors.text_dark),),
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

             DropdownMenu<Trang_thai_so_phu>(
              width: 100,
              initialSelection: Trang_thai_so_phu._no,
              textStyle:  const TextStyle(color: AppColors.text_dark),
              controller: trang_thai_so_phu_controller,
              requestFocusOnTap: true,
              label: const Text('Số phụ',   style: TextStyle(color: AppColors.text_dark),),
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

        
              SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(color: AppColors.text_dark),
                      controller: _controller_videoId,
                     // keyboardType: TextInputType.number,
                     
                      
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(

                        ),
                        labelText: 'VideoId',
                      //  hintStyle: TextStyle(color: AppColors.textColor)
                        
                      ),
                      onEditingComplete: () =>
                        doi_video(_videoId),
                      onChanged: (value) {
                       
                        setState(() {
                          _videoId = value;
                        });
                      },
                    ),
                  ),



             DropdownMenu<Reset_err>(
              width: 100,
              initialSelection: Reset_err._no,
              textStyle:  const  TextStyle(color: AppColors.text_dark),
              controller: reset_err_controller,
              requestFocusOnTap: true,
              label: const Text('Reset Error',    style: TextStyle(color: AppColors.text_dark)),
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
              width: 100,
              initialSelection: Do_nghieng._no,
              textStyle:   const  TextStyle(color: AppColors.text_dark),
              controller: do_nghieng_controller,
              requestFocusOnTap: true,
              label: const Text('Độ nghiêng',   style: TextStyle(color: AppColors.text_dark),),
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
            ),
          ),
        ),
       
      ],
    );
  }
}
