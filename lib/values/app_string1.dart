import 'package:shared_preferences/shared_preferences.dart';

class AppStrings1 {
  static late String loginAndRegister;
  static late String uhOhPageNotFound;
  static late String register;
  static late String login;
  static late String logout;
  static late String createYourAccount;
  static late String doNotHaveAnAccount;
  static late String facebook;
  static late String google;
  static late String signInToYourAccount;
  static late String iHaveAnAccount;
  static late String forgotPassword;
  static late String orLoginWith;
  static late String loggedIn;
  static late String registrationComplete;
  static late String name;
  static late String pleaseEnterName;
  static late String invalidName;
  static late String username;
  static late String pleaseEnterUsername;
  static late String invalidUsername;
  static late String password;
  static late String pleaseEnterPassword;
  static late String invalidPassword;
  static late String confirmPassword;
  static late String pleaseReEnterPassword;
  static late String passwordNotMatched;
  static late String homeTitleAppbarr;
  static late String tractorTitleAppbarr;
  static late String mapTitleAppbarr;
  static late String ProfileTitle;
  static late String ProfileSetting;
  static late String ProfileUser;
  static late String ProfileInfomation;
  static late String BottombarHome;
  static late String BottombarTractor;
  static late String BottombarMap;
  static late String BottombarProfile;
  static late String SettingTitle;
  static late String AccountManageTitle;
  static late String InfomationTitle;
  static late String FieldTitle;
  static late String FieldBottomTitle;
  static late String addFieldTitle;
  static late String notiTitle;

  static late String dialog_errorTitle;
  static late String dialog_err_field_name;
  static late String dialog_close;
  static late String dialog_noti_title;
  static late String dialog_addfiled_success;
  static late String dialog_has_error;

  static late String addfiled_color_border;
  static late String addfiled_color_fill;
  static late String addfiled_border_width;
  static late String addfiled_opacity;

  static late String addfiled_fieldname;
  static late String addfield_save;
  static late String addfield_delete;

  static late String color;
  static late String color_shade;

  static late String map_reload;

  static late String noti_date_justnow;
  static late String noti_date_minute_ago;
  static late String noti_date_hours_ago;
  static late String noti_date_day_ago;
  static late String noti_delete_noti;

  static late String err_disconected_server;

  static late String language_dialog_title;
  static late String language_dialog_body;
  static late String language_dialog_close;
  static late String language_dialog_notclose;

  static late String enum_trangthaimaycay_pause;
  static late String enum_trangthaimaycay_continue;
  static late String enum_trangthaiden_on;
  static late String enum_trangthaiden_off;
  static late String enum_trangthaisophu_nomal;
  static late String enum_trangthaisophu_fast;
  static late String enum_reseterr_reset;
  static late String enum_donghieng_1;
  static late String enum_donghieng_2;
  static late String enum_donghieng_3;

  static late String tractor_state_state;
  static late String tractor_state_maxrpm;
  static late String tractor_state_minrpm;
  static late String tractor_state_so_cang;
  static late String tractor_state_tam_de;
  static late String tractor_state_light;
  static late String tractor_state_so_phu;
  static late String tractor_state_reseterr;
  static late String tractor_state_do_nghieng;

  static late String tractor_btn_detail;
  static late String tractor_btn_see_on_map;

  static late String tractor_progress;
  static late String tractor_batterry;
  static late String tractor_speed;
  static late String tractor_fuel;
  static late String tractor_offline;

  static late String tractor_sensor_on;
  static late String tractor_sensor_off;

  static late String piechart_roaded_title;
  static late String piechart_road_left_title;
  static late String piechart_timeed_title;
  static late String piechart_time_left_title;

  static late String linechart_dan_xoi_cacul;
  static late String linechart_dan_xoi_real;
  static late String linechart_yaw;
  static late String linechart_pitch;
  static late String linechar_roll;

  static late String sensor_title_power;
  static late String sensor_title_switch;
  static late String sensor_title_starter;
  static late String sensor_title_front_light;
  static late String sensor_title_back_light;
  static late String sensor_title_temp_fuel;
  static late String sensor_title_temp_engine;
  static late String sensor_title_asmostphere;
  static late String sensor_title_humidity;

  static late String account_change_password;
  static late String old_password;
  static late String new_password;
  static late String confirm_new_password;
  // Add other strings here...

  static late String setting_language;
  static late String settings_darkmode;

  static late String select_image_galary;
  static late String select_image_camera;

  static Future<void> loadLanguageStrings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('selected_language');

    // Default to Vietnamese if no language is selected
    if (selectedLanguage == null || selectedLanguage.isEmpty) {
      selectedLanguage = 'Vietnamese';
      prefs.setString('selected_language', selectedLanguage);
    }

    switch (selectedLanguage) {
      case 'English':
        loginAndRegister = 'Login and Register UI';
        uhOhPageNotFound = 'uh-oh!\nPage not found';
        register = 'Register';
        login = 'Login';
        logout = 'Logout';
        createYourAccount = 'Create your account';
        doNotHaveAnAccount = 'Do not have an account?';
        signInToYourAccount = 'Sign in to your account';
        iHaveAnAccount = 'I have an account';
        forgotPassword = 'Forgot password?';
        loggedIn = 'Login successfully!';
        registrationComplete = 'Register successfully!';
        name = 'Name';
        pleaseEnterName = 'Please enter name';
        invalidName = 'Invalid name';
        username = 'Username';
        pleaseEnterUsername = 'Please enter username';
        invalidUsername = 'Invalid username';
        password = 'Password';
        pleaseEnterPassword = 'Please enter password';
        invalidPassword = 'Invalid password';
        confirmPassword = 'Confirm password';
        pleaseReEnterPassword = 'Please reenter password';
        passwordNotMatched = 'Password not match!';
        homeTitleAppbarr = 'Home';
        tractorTitleAppbarr = 'Tractors';
        mapTitleAppbarr = 'Map';
        ProfileTitle = 'Profile';
        ProfileSetting = 'Settings';
        ProfileInfomation = 'Infomation';
        ProfileUser = 'User Infomation';
        BottombarHome = 'Home';
        BottombarMap = 'Map';
        BottombarTractor = 'Tractors';
        BottombarProfile = 'Profile';

        SettingTitle = 'Settings';
        AccountManageTitle = 'Account manager';
        InfomationTitle = 'Infomation';

        FieldTitle = 'Fields';
        FieldBottomTitle = 'Fields';
        addFieldTitle = 'Add field';

        notiTitle = 'Notifications';

        dialog_errorTitle = 'Error';
        dialog_err_field_name = 'Enter filedname!';
        dialog_close = 'Close';
        dialog_addfiled_success = 'Add field successfully!';
        dialog_has_error = 'Some error are happening! Try again';
        dialog_noti_title = 'Notification';

        addfiled_color_border = 'Border color';
        addfiled_border_width = 'Border width';
        addfiled_color_fill = 'Fill color';
        addfiled_opacity = 'Opacity';

        addfiled_fieldname = 'Fieldname';
        addfield_delete = 'Delete';
        addfield_save = 'Save';

        color = 'Select Color';
        color_shade = 'Select color shades';

        map_reload = 'Reload';

        noti_date_justnow = 'Just now';
        noti_date_minute_ago = 'minutes ago';
        noti_date_hours_ago = 'hours ago';
        noti_date_day_ago = 'days ago';
        noti_delete_noti = 'Delete this notification';

        err_disconected_server = 'Disconect from server';

        language_dialog_title = 'Change language';
        language_dialog_body = 'Do you want to restart app to apply change?';
        language_dialog_close = 'Ok';
        language_dialog_notclose = 'Cancel';

        enum_trangthaimaycay_pause = 'Pause';
        enum_trangthaimaycay_continue = 'Continue';
        enum_trangthaiden_on = 'On';
        enum_trangthaiden_off = 'Off';
        enum_trangthaisophu_fast = 'Fast';
        enum_trangthaisophu_nomal = 'Nomal';
        enum_reseterr_reset = 'Reset';
        enum_donghieng_1 = 'Tilt one axis';
        enum_donghieng_2 = 'Tilt two axis';
        enum_donghieng_3 = 'Tilt three axis';

        tractor_state_state = 'Tractor state';
        tractor_state_light = 'Light';
        tractor_state_maxrpm = 'Max Rpm';
        tractor_state_minrpm = 'Min Rpm';
        tractor_state_so_phu = 'Secondary gearbox';
        tractor_state_so_cang = 'Pillow level';
        tractor_state_reseterr = 'Reset error';
        tractor_state_tam_de = 'Plate';
        tractor_state_do_nghieng = 'Pitch';

        tractor_btn_detail = 'More detail';
        tractor_btn_see_on_map = 'See on map';

        tractor_progress = 'Progress';
        tractor_batterry = 'Battery';
        tractor_fuel = "Fuel";
        tractor_speed = 'Speed';
        tractor_offline = 'Offline';

        tractor_sensor_on = 'On';
        tractor_sensor_off = 'Off';

        piechart_roaded_title = 'The distance has been plowed';
        piechart_road_left_title = 'The distance left';
        piechart_timeed_title = 'Time has plowed';
        piechart_time_left_title = 'Time left';

        linechart_dan_xoi_cacul = 'Calculated tiller tilt';
        linechart_dan_xoi_real = 'Realality tiller tilt';
        linechar_roll = 'Roll';
        linechart_pitch = 'Pitch';
        linechart_yaw = 'Yaw';

        sensor_title_power = 'Power';
        sensor_title_switch = 'Switch';
        sensor_title_starter = 'Starter';
        sensor_title_front_light = 'Front light';
        sensor_title_back_light = 'Back light';
        sensor_title_temp_engine = 'Engine temperature';
        sensor_title_temp_fuel = 'Fuel tank temperature';
        sensor_title_humidity = 'Humidity';
        sensor_title_asmostphere = 'Pressure';

        setting_language = 'Language';
        settings_darkmode = 'Darkmode';

        account_change_password = 'Change password';
        old_password = 'Old password';
        new_password = 'New password';
        confirm_new_password = 'Confirm new password';

        select_image_galary = 'Select from galary';
        select_image_camera = 'Open camera';
        // Assign other English strings here...
        break;

      case 'Vietnamese':
      default:
        loginAndRegister = 'Login and Register UI';
        uhOhPageNotFound = 'uh-oh!\nPage not found';
        register = 'Đăng kí';
        login = 'Đăng nhập';
        logout = 'Đăng xuất';
        createYourAccount = 'Tạo tài khoản';
        doNotHaveAnAccount = 'Bạn chưa có tài khoản?';
        signInToYourAccount = 'Đăng nhập vào tài khaonr của bạn';
        iHaveAnAccount = 'Đã có tài khoản';
        forgotPassword = 'Quên mật khẩu?';
        loggedIn = 'Đăng nhập thành công!';
        registrationComplete = 'Đăng ký thành công!';
        name = 'Tên';
        pleaseEnterName = 'Vui lòng nhập tên';
        invalidName = 'Tên không hợp lệ!';
        username = 'Tên người dùng';
        pleaseEnterUsername = 'Vui lòng nhập tên người dùng!';
        invalidUsername = 'Tên người dùng không hợp lệ!';
        password = 'Mật khẩu';
        pleaseEnterPassword = 'Vui lòng nhập mật khẩu!';
        invalidPassword = 'Mật khẩu không hợp lệ!';
        confirmPassword = 'Xác nhận mật khẩu';
        pleaseReEnterPassword = 'Vui lòng nhập lại mật khẩu!';
        passwordNotMatched = 'Mật khẩu không trùng nhau!';
        homeTitleAppbarr = 'Trang chủ';
        tractorTitleAppbarr = 'Máy cày';
        mapTitleAppbarr = 'Bản đồ';
        ProfileTitle = 'Tài khoản';
        ProfileSetting = 'Cài đặt';
        ProfileInfomation = 'Thông tin';
        ProfileUser = 'Thông tin tài khoản';
        BottombarHome = 'Trang chủ';
        BottombarMap = 'Bản đồ';
        BottombarTractor = 'Máy cày';
        BottombarProfile = 'Tài khoản';

        SettingTitle = 'Cài đặt';
        AccountManageTitle = 'Quản lí tài khoản';
        InfomationTitle = 'Thông tin';

        FieldTitle = 'Ruộng';
        FieldBottomTitle = 'Ruộng';
        addFieldTitle = 'Thêm ruộng';

        notiTitle = 'Thông báo';

        dialog_errorTitle = 'Lỗi';
        dialog_err_field_name = 'Hãy nhập tên ruộng!';
        dialog_close = 'Đóng';
        dialog_addfiled_success = 'Thêm ruộng thành công!';
        dialog_has_error = 'Có lỗi xảy ra! Hãy thử lại sau';
        dialog_noti_title = 'Thông báo';

        addfiled_color_border = 'Màu viền';
        addfiled_border_width = 'Độ dày viền';
        addfiled_color_fill = 'Màu phủ';
        addfiled_opacity = 'Độ trong suốt';

        addfiled_fieldname = 'Tên ruộng';
        addfield_delete = 'Xóa';
        addfield_save = 'Lưu';

        color = 'Chọn màu';
        color_shade = 'Chọn màu trộn';

        map_reload = 'Tải lại';

        noti_date_justnow = 'Vừa xong';
        noti_date_minute_ago = 'phút trước';
        noti_date_hours_ago = 'giờ trước';
        noti_date_day_ago = 'ngày trước';
        noti_delete_noti = 'Xóa thông báo này';

        err_disconected_server = 'Mất kết nối tới máy chủ!';

        language_dialog_title = 'Đổi ngôn ngữ';
        language_dialog_body = 'Khởi động lại ứng dụng để áp dụng thay đổi?';
        language_dialog_close = 'Ok';
        language_dialog_notclose = 'Quay lại';

        enum_trangthaimaycay_pause = 'Dừng';
        enum_trangthaimaycay_continue = 'Tiếp tục';
        enum_trangthaiden_on = 'Bật';
        enum_trangthaiden_off = 'Tắt';
        enum_trangthaisophu_fast = 'Nhanh';
        enum_trangthaisophu_nomal = 'Bình thường';
        enum_reseterr_reset = 'Reset';
        enum_donghieng_1 = 'Nghiêng 1 trục';
        enum_donghieng_2 = 'Nghiêng 2 trục';
        enum_donghieng_3 = 'Nghiêng 3 trục';

        tractor_state_state = 'Trạng thái';
        tractor_state_light = 'Đèn';
        tractor_state_maxrpm = 'Max Rpm';
        tractor_state_minrpm = 'Min Rpm';
        tractor_state_so_phu = 'Số phụ';
        tractor_state_so_cang = 'Số càng';
        tractor_state_reseterr = 'Reset lỗi';
        tractor_state_tam_de = 'Tấm dè';
        tractor_state_do_nghieng = 'Độ nghiêng';

        tractor_btn_detail = 'Xem chi tiết';
        tractor_btn_see_on_map = 'Xem trên bản đồ';

        tractor_progress = 'Tiến độ';
        tractor_batterry = 'Pin';
        tractor_fuel = "Nhiên liệu";
        tractor_speed = 'Tốc độ';
        tractor_offline = 'Không hoạt động';

        tractor_sensor_on = 'Bật';
        tractor_sensor_off = 'Tắt';

        piechart_roaded_title = 'Quãng đường đã đi';
        piechart_road_left_title = 'Quãng đường còn lại';
        piechart_timeed_title = 'Thời gian đã đi';
        piechart_time_left_title = 'Thời gian còn lại';

        linechart_dan_xoi_cacul = 'Độ nghiêng dàn xới mong muốn';
        linechart_dan_xoi_real = 'Độ nghiêng dàn xới thực tế';
        linechar_roll = 'Góc quay - Roll';
        linechart_pitch = 'Góc nghiêng - Pitch';
        linechart_yaw = 'Góc chúc - Yaw';

        sensor_title_power = 'Nguồn';
        sensor_title_switch = 'Chuyên mạch';
        sensor_title_starter = 'Đề';
        sensor_title_front_light = 'Đèn trước';
        sensor_title_back_light = 'Đèn sau';
        sensor_title_temp_engine = 'Nhiệt độ động cơ';
        sensor_title_temp_fuel = 'Nhiệt độ bình nguyên liệu';
        sensor_title_humidity = 'Độ ẩm';
        sensor_title_asmostphere = 'Áp suất';

        setting_language = 'Ngôn ngữ';
        settings_darkmode = 'Chế độ tối';

        account_change_password = 'Đổi mật khẩu';
         old_password = 'Mật khẩu cũ';
        new_password = 'Mật khẩu mới';
        confirm_new_password = 'Xác nhận mật khẩu mới';

        select_image_galary = 'Chọn ảnh từ thư viện';
        select_image_camera = 'Chụp từ camera';
        break;
    }
  }
}
