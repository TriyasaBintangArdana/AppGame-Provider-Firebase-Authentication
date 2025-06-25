import 'dart:io';

import 'package:app_games/core/widgets/button/button_type.dart';
import 'package:app_games/core/widgets/button/primary_button.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/dialog/app_dialog.dart';
import 'package:app_games/core/widgets/text_field/input_text.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_login/domain/entities/authentication_user.dart';
import 'package:app_games/modules/feature_user/presentation/state/request_state.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNick = TextEditingController();
  final TextEditingController _controllerBalance = TextEditingController();
  File? _pickedImage;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<HomeViewModel>(context, listen: false);
      await viewModel.getUser();
      final user = viewModel.user;
      if (user != null) {
        _controllerEmail.text = user.email ?? "";
        _controllerNick.text = user.name ?? "";
        _controllerBalance.text = user.balance.toString();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerNick.dispose();
    _controllerEmail.dispose();
    _controllerBalance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    if (viewModel.user == null) {
      return Scaffold(
        backgroundColor: greyBlack,
        appBar: AppBar(
          backgroundColor: greyBlack,
          title: Text("Profile", style: TextStyles.body1),
          centerTitle: true,
          elevation: 3,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: greyBlack,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: greyBlack,
        title: Text("Profile", style: TextStyles.body1),
        centerTitle: true,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child:
                        _pickedImage != null
                            ? CircleAvatar(
                              radius: 38,
                              backgroundImage: FileImage(_pickedImage!),
                            )
                            : viewModel.user!.photoUrl!.isNotEmpty
                            ? CircleAvatar(
                              radius: 38,
                              backgroundImage: FileImage(
                                File(viewModel.user?.photoUrl ?? ""),
                              ),
                            )
                            : const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        final picked = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (picked != null) {
                          setState(() {
                            _pickedImage = File(picked.path);
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: greyBlack,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InputTextField(label: "Nickname", controller: _controllerNick),
            const SizedBox(height: 10),
            InputTextField(label: "Email", controller: _controllerEmail),
            const SizedBox(height: 10),
            InputTextField(label: "Balance", controller: _controllerBalance),
            const SizedBox(height: 10),
            PrimaryButton(
              "Save",
              buttonType: MediumButtonType(),
              onTap: () async {
                

                final result = await viewModel.updateProfile(
                  user: AuthenticationUser(
                    email: _controllerEmail.text,
                    name: _controllerNick.text,
                    uid: viewModel.user!.uid,
                    photoUrl: viewModel.user!.photoUrl,
                    balance: int.parse(_controllerBalance.text),
                    createdAt: viewModel.user!.createdAt,
                  ),
                );

                if (result == RequestState.success()) {
                  AppDialog.showNotifSuccessDialog(
                    context: context,
                  );
                 await Future.delayed(Duration(seconds:2));
                  context.go("/nav");
                } else {
                  AppDialog.showErrorDialog(
                    context: context,
                    message: "Gagal Mengubah Profile",
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              "Change Password",
              buttonType: MediumButtonType(),
              onTap: () {
                context.pushNamed("change-password");
              },
            ),
          ],
        ),
      ),
    );
  }
}
