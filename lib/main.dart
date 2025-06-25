import 'package:app_games/core/injection/injection.dart';
import 'package:app_games/core/router/router.dart';
import 'package:app_games/firebase_options.dart';
import 'package:app_games/modules/feature_login/presentation/view_model/login_view_model.dart';
import 'package:app_games/modules/feature_login/presentation/view_model/register_view_model.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/detail_home_view_model.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/detail_movie/detail_game_view_model.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/home_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  injection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>injeksi<LoginViewModel>()),
        ChangeNotifierProvider(create: (context) => injeksi<RegisterViewModel>()),
        ChangeNotifierProvider(create: (context) => injeksi<HomeViewModel>()),
        ChangeNotifierProvider(create: (context) => injeksi<DetailHomeViewModel>()),
        ChangeNotifierProvider(create: (context) => injeksi<DetailGameViewModel>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        routerConfig: router,
      ),
    );
  }
}

