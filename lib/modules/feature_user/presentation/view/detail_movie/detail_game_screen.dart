import 'package:app_games/core/injection/injection.dart';
import 'package:app_games/core/widgets/button/button_type.dart';
import 'package:app_games/core/widgets/button/primary_button.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_user/data/models/detail_list_game_models.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/detail_movie/detail_game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailGameScreen extends StatefulWidget {
  final String id;
  const DetailGameScreen({super.key, required this.id});

  static Widget create(String id) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DetailGameViewModel(useCase: injeksi()),
        ),
      ],
      child: DetailGameScreen(id: id),
    );
  }

  @override
  State<DetailGameScreen> createState() => _DetailGameScreenState();
}

class _DetailGameScreenState extends State<DetailGameScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<DetailGameViewModel>(
        context,
        listen: false,
      ).getDetailGame(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailGameViewModel>(
      builder: (context, viewModel, child) {
        return _buildPage(context, viewModel);
      },
    );
  }

  Widget _buildPage(BuildContext context, DetailGameViewModel viewModel) {
    if (viewModel.isLoading) {
      return Scaffold(
        backgroundColor: greyBlack,
        body: Center(child: CircularProgressIndicator(color: white)),
      );
    }
    return Scaffold(
      backgroundColor: greyBlack,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Ganti sesuai warna yang kamu mau
        ),
        title: Text("Detail Game", style: TextStyles.h2),
        centerTitle: true,
        backgroundColor: greyBlack,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x13000000),
                  blurRadius: 19.5,
                  offset: Offset(0, 6.5),
                  spreadRadius: 6.5,
                ),
              ],
            ),
            child: Image.asset("assets/images/bg_stack.png", fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child:
                      viewModel.detailListGame?.thumbnail != null &&
                              viewModel.detailListGame!.thumbnail!.startsWith(
                                'http',
                              )
                          ? Image.network(
                            viewModel.detailListGame!.thumbnail!,
                            fit: BoxFit.contain,
                          )
                          : Placeholder(
                            fallbackHeight: 200,
                            fallbackWidth: double.infinity,
                            color: Colors.grey,
                          ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Name : ${viewModel.detailListGame?.title}",
                  style: TextStyles.body1,
                ),
                const SizedBox(height: 10),
                Text(
                  "Developer : ${viewModel.detailListGame?.developer},",
                  style: TextStyles.body1,
                ),
                const SizedBox(height: 10),
                Text(
                  "Genre : ${viewModel.detailListGame?.genre}",
                  style: TextStyles.body1,
                ),
                const SizedBox(height: 10),
                Text(
                  "Platform : ${viewModel.detailListGame?.platform}",
                  style: TextStyles.body1,
                ),
                const SizedBox(height: 10),
                Text(
                  "Release Date : ${viewModel.detailListGame?.releaseDate}",
                  style: TextStyles.body1,
                ),
                const SizedBox(height: 10),
                Text("Mininum Requirements :", style: TextStyles.body1),
                Text(
                  " - OS : ${viewModel.detailListGame?.minimumSystemRequirements?.os ?? "Unavaiable"}",
                  style: TextStyles.body1,
                ),
                Text(
                  " - Graphics : ${viewModel.detailListGame?.minimumSystemRequirements?.graphics ?? "Unavaiable"}",
                  style: TextStyles.body1,
                ),
                Text(
                  " - Memory : ${viewModel.detailListGame?.minimumSystemRequirements?.memory ?? "Unavaiable"}",
                  style: TextStyles.body1,
                ),
                Text(
                  " - Procesor : ${viewModel.detailListGame?.minimumSystemRequirements?.processor ?? "Unavaiable"}",
                  style: TextStyles.body1,
                ),
                Text(
                  " - Storage : ${viewModel.detailListGame?.minimumSystemRequirements?.storage ?? "Unavaiable"}",
                  style: TextStyles.body1,
                ),
                const SizedBox(height: 10),
                Text(
                  "Description : ${viewModel.detailListGame?.description ?? "Unavaiable"}",
                  style: TextStyles.body1,
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        viewModel.detailListGame?.screenshots
                            .map((game) => _buildScreenShot(context, game))
                            .toList() ??
                        [],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      'Register Now',
                      buttonType: MediumButtonType(),
                      onTap: () {
                        viewModel.generateAndLaunch(
                          viewModel.detailListGame?.gameUrl,
                        );
                      },
                    ),
                    PrimaryButton(
                      'Game Now',
                      buttonType: MediumButtonType(),
                      onTap: () {
                        viewModel.generateAndLaunch(
                          viewModel.detailListGame?.freetogameProfileUrl,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenShot(BuildContext context, Screenshot game) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Container(
          width: mediaQueryWidth,
          height: mediaQueryHeight * 0.33,
          child: Image.network(game.image ?? "", fit: BoxFit.contain),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
