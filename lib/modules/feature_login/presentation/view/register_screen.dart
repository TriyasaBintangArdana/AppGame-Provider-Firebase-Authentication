import 'package:app_games/core/injection/injection.dart';
import 'package:app_games/core/widgets/button/app_text_button.dart';
import 'package:app_games/core/widgets/button/button_type.dart';
import 'package:app_games/core/widgets/button/primary_button.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/dialog/app_dialog.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_login/presentation/view_model/register_view_model.dart';
import 'package:app_games/core/widgets/text_field/input_text.dart';
import 'package:app_games/core/widgets/text_field/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    

    void showFailedSignUpServerDialog() {
    if (context.mounted) {
      AppDialog.showErrorDialog(
        context: context,
        message:
            "Something Wrong! Email was Used!",
      );
    }
  }
    void showFailedSignUpClientDialog() {
    if (context.mounted) {
      AppDialog.showErrorDialog(
        context: context,
        message:
            "Please Check All Form",
      );
    }
  }
    void showConfirmSignupDialog() {
    if (context.mounted) {
      AppDialog.showSuccessDialog(
        context: context,
        message:
            "Silahkan Cek Email Anda Untuk Verifikasi Akun Anda!",
      );
    }
  }
  @override
  dispose() {
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context, listen: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterViewModel(useCase: injeksi()),
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
                  "assets/images/signup.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text("Sign Up",style: TextStyles.h3Bold,),
              const SizedBox(height: 20),
              InputTextField(
                controller: userNameController,
                hintText: "Username",
              ),
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
              const SizedBox(height: 20),
              PasswordTextField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                "Sign Up",
                isLoading: viewModel.isLoading,
                buttonType: MediumButtonType(),
                onTap: () async {
                  final result = await viewModel.register(
                    emailController.text,
                    passwordController.text,
                    userNameController.text,
                  );
                  result.when(
                    serverError: () {
                      showFailedSignUpServerDialog();
                    },
                    clientError: () {
                      showFailedSignUpClientDialog();
                    },
                    success: () {
                     showConfirmSignupDialog();
                      Future.delayed(const Duration(seconds: 3), () {
                        context.pushReplacement("/login");
                      });
                    },
                  );
                },
              ),
              const SizedBox(height:20),
              AppTextButton(
                "Sudah Punya Akun? Masuk",
                onTap: () {
                  context.push("/login");
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