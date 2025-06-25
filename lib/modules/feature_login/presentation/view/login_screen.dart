import 'package:app_games/core/injection/injection.dart';
import 'package:app_games/core/widgets/button/app_text_button.dart';
import 'package:app_games/core/widgets/button/button_type.dart';
import 'package:app_games/core/widgets/button/primary_button.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/dialog/app_dialog.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_login/presentation/view_model/login_view_model.dart';
import 'package:app_games/core/widgets/text_field/input_text.dart';
import 'package:app_games/core/widgets/text_field/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(useCase: injeksi(),sharedPreferences: injeksi()),
        ),
      ],
    child: Scaffold(
      backgroundColor: greyBlack,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
             Container(
                width: double.infinity,
                height: 150,
                child: Image.asset(
                  "assets/images/login.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text("Login",style: TextStyles.h3Bold,),
              const SizedBox(height: 20),
              InputTextField(
                controller: emailController,
                hintText: "Email",
              ),
              const SizedBox(height: 20),
              PasswordTextField(
                controller: passwordController,
                hintText: "Password",
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: AppTextButton(
                  "Lupa Password?",
                  onTap: () {
                    context.pushReplacement("/forgot-password");
                  },
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                "Login",
                buttonType: MediumButtonType(),
                onTap: () async {
                  final viewModel = Provider.of<LoginViewModel>(context, listen: false);
                  final result = await viewModel.login(
                    emailController.text,
                    passwordController.text,
                  );
                  result.when(
                    serverError: () {
                     AppDialog.showErrorDialog(
                      context: context, 
                      message: "Periksa Kata Sandi atau Email dengan benar!");
                    },
                    clientError: () {
                      AppDialog.showErrorDialog(
                      context: context, 
                      message: "Periksa Kata Sandi atau Email dengan benar!");
                    },
                    success: () async {
                      AppDialog.showNotifSuccessDialog(
                      context: context, 
                      );
                      await Future.delayed(Duration(seconds: 3));
                      context.pushReplacement("/nav");
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
                    AppTextButton(
                      "Belum punya akun? Daftar disini",
                      onTap: () {
                        context.push("/register");
                      },
                    ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}