import 'package:app_games/core/injection/injection.dart';
import 'package:app_games/core/widgets/button/button_type.dart';
import 'package:app_games/core/widgets/button/primary_button.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/dialog/app_dialog.dart';
import 'package:app_games/core/widgets/text_field/input_text.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_login/presentation/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
   void showConfirmSignupDialog() {
    if (context.mounted) {
      AppDialog.showSuccessDialog(
        context: context,
        message:
            "Silahkan Cek Email Anda!",
      );
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => LoginViewModel(useCase: injeksi(), sharedPreferences: injeksi()),
      ),
    ],
    child: Scaffold(
      backgroundColor: greyBlack,
      body: Center(
        child: Container(
          width: 300,
          height: 220,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0x13000000),
                blurRadius: 19.5,
                offset: Offset(0, 6.5),
                spreadRadius: 6.5,
              ),
            ],
          ),
          child: Column(
            children: [
              Text("Masukan Email Anda",style: TextStyles.h3.copyWith(color: greyBlack),),
              const SizedBox(height:20),
              InputTextField(
                controller: emailController,
                hintText: "Masukan Email Anda",
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                "Kirim",
                buttonType: MediumButtonType(),
                onTap: () async {
                  final viewModel = Provider.of<LoginViewModel>(context, listen: false);
                  final result = await viewModel.forgotPassword(emailController.text);
                  result.when(
                  serverError: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Server Error")),
                    );
                  },
                  clientError: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Client Error")),
                    );
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
            ],
          )
          ),
      ),
    ),);
  }
}