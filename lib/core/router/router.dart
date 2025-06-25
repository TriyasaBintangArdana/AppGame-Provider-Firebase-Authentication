import 'package:app_games/modules/feature_login/presentation/view/forgot_password_screen.dart';
import 'package:app_games/modules/feature_login/presentation/view/login_screen.dart';
import 'package:app_games/modules/feature_login/presentation/view/register_screen.dart';
import 'package:app_games/modules/feature_login/presentation/view/splash_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/detail_home/detail_home_all_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/detail_home/detail_home_category_platform_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/detail_home/detail_home_category_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/detail_home/detail_home_platform_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/detail_movie/detail_game_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/home/home_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/navigation.dart';
import 'package:app_games/modules/feature_user/presentation/view/favorite/favorite_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/profile/change_password_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter get router => _router;

final _router = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/nav',
      name: 'nav',
      builder: (context, state) => const NavigationScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/change-password',
      name: 'change-password',
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: '/favorite',
      name: 'favorite',
      builder: (context, state) => const FavoriteScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: HomeScreen.create(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      routes: [
        GoRoute(
          path: '/detail-game',
          name: 'detail-game',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: DetailGameScreen.create(
                state.uri.queryParameters['id'] ?? ""
              ),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: '/detail-home-all',
          name: 'detail-home-all',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: DetailHomeAllScreen.create(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: '/detail-home-category',
          name: 'detail-home-category',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: DetailHomeCategoryScreen.create(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: '/detail-home-platform',
          name: 'detail-home-platform',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: DetailHomePlatformScreen.create(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: '/detail-home-platform-category',
          name: 'detail-home-platform-category',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: DetailHomeCategoryPlatformScreen.create(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
      ],
    ),
  ],
);
