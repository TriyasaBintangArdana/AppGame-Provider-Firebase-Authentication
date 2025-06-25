import 'dart:io';

import 'package:app_games/core/injection/injection.dart';
import 'package:app_games/core/widgets/button/app_text_button.dart';
import 'package:app_games/core/widgets/button/button_type.dart';
import 'package:app_games/core/widgets/button/primary_button.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_user/presentation/view/home/home_fragment.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Widget create() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(useCase: injeksi()),
        ),
      ],
      child: const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      final viewModel = Provider.of<HomeViewModel>(context, listen: false);
      viewModel.getUser();
      viewModel.getAllGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Scaffold(
            backgroundColor: greyBlack,
            body: Center(
              child: CircularProgressIndicator(
                color: white,
              ),
            ),
          );
        }
        return _buildPage(context, viewModel);
      },
    );
  }

  Widget _buildPage(BuildContext context, HomeViewModel viewModel) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: greyBlack,
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: greyBlack,
        title: Text(
          "Halo, ${viewModel.user?.name ?? 'No user found'}",
          style: TextStyles.body2,
        ),
        elevation: 3,
      ),
      drawer: NavDrawer(viewModel: viewModel,),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Games",
                  style: TextStyles.body1.copyWith(color: white),
                ),
                AppTextButton("See All", onTap: () {
                  context.pushNamed("detail-home-all");
                }),
              ],
            ),
            const SizedBox(height: 10),
            DisplayGame(mediaQuery: mediaQuery, games: viewModel.listGame),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Games By Category",
                  style: TextStyles.body1.copyWith(color: white),
                ),
                AppTextButton("See All", onTap: () {
                  context.pushNamed("detail-home-category");
                }),
              ],
            ),
            const SizedBox(height: 10),
            DisplayGame(
              mediaQuery: mediaQuery,
              games:
                  viewModel.listGame
                      .where((element) => element?.genre == 'MMORPG')
                      .toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Games By Platform",
                  style: TextStyles.body1.copyWith(color: white),
                ),
                AppTextButton("See All", onTap: () {
                   context.pushNamed("detail-home-platform");
                }),
              ],
            ),
            const SizedBox(height: 10),
            DisplayGame(
              mediaQuery: mediaQuery,
              games:
                  viewModel.listGame
                      .where((element) => element?.platform == 'Web Browser')
                      .toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Platform & Category",
                  style: TextStyles.body1.copyWith(color: white),
                ),
                AppTextButton("See All", onTap: () {
                  context.pushNamed("detail-home-platform-category");
                }),
              ],
            ),
            const SizedBox(height: 10),
            DisplayGame(
              mediaQuery: mediaQuery,
              games:
                  viewModel.listGame
                      .where((element) => element?.platform == 'Web Browser' && element?.genre == 'MMORPG')
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    super.key,
    required this.viewModel,
  });
  final HomeViewModel viewModel;
  @override
Widget build(BuildContext context) {
  return Drawer(
    width: 300,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    backgroundColor: greyBlack,
    child: Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: greyBlack),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: white,
                      child: (viewModel.user?.photoUrl ?? "").isNotEmpty
                          ? CircleAvatar(
                              radius: 38,
                              backgroundImage:
                                  FileImage(File(viewModel.user?.photoUrl ?? "")),
                            )
                          : const Icon(
                              Icons.person,
                              size: 60,
                              color: greyBlack,
                            ),
                    ),
                    Text(
                      '${viewModel.user?.name ?? ""}',
                      style: TextStyles.body1.copyWith(color: white),
                    ),
                    Text(
                      '${viewModel.user?.email ?? ""}',
                      style: TextStyles.body2.copyWith(color: white),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: white),
                title:
                    Text('Home', style: TextStyles.body2.copyWith(color: white)),
                onTap: () {
                  context.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: white),
                title:
                    Text('Profile', style: TextStyles.body2.copyWith(color: white)),
                onTap: () {
                  context.pushNamed("profile");
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: white),
                title: Text(
                  'Settings',
                  style: TextStyles.body2.copyWith(color: white),
                ),
                onTap: () {
                  // context.pushNamed("percobaan");
                },
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
            "Logout",
            buttonType: MediumButtonType(),
            onTap: () {
              viewModel.logout();
              context.pushReplacementNamed('login');
            },
          ),
        ),
      ],
    ),
  );
}

}
