import 'package:flutter/material.dart';
import 'youtube.srteam.dart';
import 'package:flutter/services.dart';
import '../../../../values/app_colors.dart';
import 'dart:developer';
import '../../../../values/app_strings.dart';

//const string  = AppStrings1.enum_trangthaimaycay_pause;
class TrangThai {
  final String label;
  final int value;

  const TrangThai._(this.label, this.value);
  static TrangThai no = TrangThai._('No', 0);
  static TrangThai pause =
      TrangThai._(AppStrings.enum_trangthaimaycay_pause, 1);
  static TrangThai continueDriving =
      TrangThai._(AppStrings.enum_trangthaimaycay_continue, 2);

  static List<TrangThai> get values => [no,pause, continueDriving];
}

class TrangThaiDen {
  final String label;
  final int value;

  const TrangThaiDen._(this.label, this.value);
  static TrangThaiDen no = TrangThaiDen._('No', 0);
  static TrangThaiDen on = TrangThaiDen._(AppStrings.enum_trangthaiden_on, 1);
  static TrangThaiDen off = TrangThaiDen._(AppStrings.enum_trangthaiden_on, 2);

  static List<TrangThaiDen> get values => [no,on, off];
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

  static List<TrangThaiSoPhu> get values => [no,nomal, fast];
}

class ReserError {
  final String label;
  final int value;

  const ReserError._(this.label, this.value);
  static ReserError no = ReserError._('No', 0);
  static ReserError reset = ReserError._(AppStrings.enum_reseterr_reset, 1);

  static List<ReserError> get values => [no,reset];
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

  static List<TrangThaiDoNghieng> get values => [no,nghieng1, nghieng2, nghieng3];
}

class ControlOnlineTractor extends StatefulWidget {
  @override
  State<ControlOnlineTractor> createState() => _StateControl();
}

class _StateControl extends State<ControlOnlineTractor>  with AutomaticKeepAliveClientMixin {
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
  String videoId = 'hz5zjKJBVxk';

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

  void doi_video(value) {
    log('aaaaaaa$value');
    setState(() {
      videoId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
     super.build(context);
    return Stack(
      children: [
        YouTubePlayerScreen(
          videoId: videoId,
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 5, right: 5),
              child: Wrap(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing:
                    8.0, // Khoảng cách giữa các phần tử trong cùng một dòng
                runSpacing: 12.0, // Khoảng cách giữa các dòng
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
                        .map<DropdownMenuEntry<TrangThai>>(
                            (TrangThai trangthai) {
                      return DropdownMenuEntry<TrangThai>(
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
                        border: OutlineInputBorder(),
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
                        .map<DropdownMenuEntry<ReserError>>(
                            (ReserError trangthai) {
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
            ),
          ),
        ),
        
      ],
    );
  }

  
     @override
       bool get wantKeepAlive => true;
}
