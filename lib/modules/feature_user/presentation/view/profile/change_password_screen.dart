import 'package:app_games/core/widgets/button/button_type.dart';
import 'package:app_games/core/widgets/button/primary_button.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/dialog/app_dialog.dart';
import 'package:app_games/core/widgets/text_field/input_text.dart';
import 'package:app_games/core/widgets/text_field/password_text_field.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerOldPassword = TextEditingController();
  final TextEditingController _controllerNewPassword = TextEditingController();
  final TextEditingController _controllerConfirmNewPassword =
      TextEditingController();
  String checkPassword = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
    _controllerOldPassword.dispose();
    _controllerNewPassword.dispose();
    _controllerConfirmNewPassword.dispose();
  }

  void cekPassword() {
    setState(() {
      if (_controllerNewPassword.text != _controllerConfirmNewPassword.text) {
        checkPassword = "Password Tidak Sama";
      } else {
        checkPassword = ""; // Reset kalau sudah sama
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: greyBlack,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Ganti sesuai warna yang kamu mau
        ),
        title: Text("Change Password", style: TextStyles.body1),
        centerTitle: true,
        backgroundColor: greyBlack,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextField(
              hintText: "Email",
              label: "Email",
              controller: _controllerEmail,
            ),
            const SizedBox(height: 10),
            PasswordTextField(
              hintText: "Old Password",
              label: "Old Password",
              controller: _controllerOldPassword,
            ),

            const SizedBox(height: 10),
            PasswordTextField(
              hintText: "New Password",
              label: "New Password",
              controller: _controllerNewPassword,
            ),
            const SizedBox(height: 10),
            PasswordTextField(
              hintText: "Confirm New Password",
              label: "Confirm New Password",
              onChanged: (value) {
                cekPassword();
              },
              controller: _controllerConfirmNewPassword,
            ),
            checkPassword.isNotEmpty
                ? Text(checkPassword, style: TextStyle(color: Colors.red))
                : SizedBox.shrink(),
            const SizedBox(height: 20),
            PrimaryButton(
              "Save",
              buttonType: MediumButtonType(),
              onTap: () async {
                try {
                  if (_controllerEmail.text.isEmpty || _controllerOldPassword.text.isEmpty || _controllerNewPassword.text.isEmpty || _controllerConfirmNewPassword.text.isEmpty) {
                     AppDialog.showErrorDialog(
                    context: context,
                    message: "Mohon Di isi Dengan Lengkap",
                  );
                  } else{
                  await viewModel.changePassword(
                    newPassword: _controllerNewPassword.text,
                    email: _controllerEmail.text,
                    oldPassword: _controllerOldPassword.text,
                  );
                  AppDialog.showNotifSuccessDialog(
                    context: context,
                  );
                  await Future.delayed(Duration(seconds: 3));
                  context.go("/nav");
                  }
                } catch (e) {
                  AppDialog.showErrorDialog(
                    context: context,
                    message: e.toString(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
