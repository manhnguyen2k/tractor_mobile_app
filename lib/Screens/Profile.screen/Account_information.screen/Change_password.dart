import 'package:flutter/material.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_string1.dart';
import '../../../components/app_text_form_field.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> oldpw_noti = ValueNotifier(true);
  final ValueNotifier<bool> newpw_noti = ValueNotifier(true);
  final ValueNotifier<bool> confirm_newpw_noti = ValueNotifier(true);

  final TextEditingController oldpw_controller = TextEditingController();
  final TextEditingController newpw_controller = TextEditingController();
  final TextEditingController confirm_newpw_controller =
      TextEditingController();

  @override
  void dispose() {
    oldpw_controller.dispose();
    newpw_controller.dispose();
    confirm_newpw_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppStrings1.account_change_password,
          style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 24.0,
              fontWeight: FontWeight.normal),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: oldpw_noti,
                builder: (_, passwordObscure, __) {
                  return AppTextFormField(
                    autofocus: true,
                    labelText: AppStrings1.old_password,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: passwordObscure,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    controller: oldpw_controller,
                    suffixIcon: IconButton(
                      onPressed: () => oldpw_noti.value = !passwordObscure,
                      style: IconButton.styleFrom(
                        minimumSize: const Size.square(48),
                      ),
                      icon: Icon(
                        passwordObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: newpw_noti,
                builder: (_, passwordObscure, __) {
                  return AppTextFormField(
                    autofocus: true,
                    labelText: AppStrings1.new_password,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    obscureText: passwordObscure,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    controller: newpw_controller,
                    suffixIcon: IconButton(
                      onPressed: () => newpw_noti.value = !passwordObscure,
                      style: IconButton.styleFrom(
                        minimumSize: const Size.square(48),
                      ),
                      icon: Icon(
                        passwordObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: confirm_newpw_noti,
                builder: (_, passwordObscure, __) {
                  return AppTextFormField(
                    autofocus: true,
                    labelText: AppStrings1.confirm_new_password,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    obscureText: passwordObscure,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    controller: confirm_newpw_controller,
                    suffixIcon: IconButton(
                      onPressed: () =>
                          confirm_newpw_noti.value = !passwordObscure,
                      style: IconButton.styleFrom(
                        minimumSize: const Size.square(48),
                      ),
                      icon: Icon(
                        passwordObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: confirm_newpw_noti,
                builder: (_, isValid, __) {
                  return FilledButton(
                    onPressed: () {
                      oldpw_controller.clear();
                      newpw_controller.clear();
                      confirm_newpw_controller.clear();
                    },
                    child: Text(AppStrings1.account_change_password),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
