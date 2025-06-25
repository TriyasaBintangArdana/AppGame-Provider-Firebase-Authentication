import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/modules/feature_login/presentation/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
     final loggedUser = Provider.of<LoginViewModel>(context, listen: false).getLoggedUser;
     Future.delayed(const Duration(seconds: 4), () {
       if (loggedUser.isNotEmpty) {
         context.pushReplacementNamed('nav');
       } else {
         context.pushReplacementNamed('login');
       }
     });
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBlack,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Image.asset("assets/images/splash.png"),
        ),
      ),
    );
  }
}