import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/dialog/app_dialog.dart';
import 'package:app_games/modules/feature_user/data/models/list_all_game_models.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DisplayGame extends StatelessWidget {
  const DisplayGame({super.key, required this.mediaQuery, required this.games});

  final double mediaQuery;
  final List<ListAllGame?> games;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(games.take(8).length, (index) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator(color: white));
          }
          final e = games[index];
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  AppDialog.showConfirmDialogChoice(
                    context: context,
                    actions: {
                      "Detail": () {
                        context.pushNamed(
                          "detail-game",
                          queryParameters: {'id': e?.id.toString() ?? ''},
                        );
                      },
                      "Add Favorite": () {
                        viewModel.insertFav(e!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sukses Menambahkan Ke Favorite"),
                          ),
                        );
                      },
                    },
                  );
                },
                child: Container(
                  width: mediaQuery * 0.42,
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        e?.thumbnail ?? "",
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: Center(
                          child: Text(
                            e?.title ?? "",
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Genre : ${e?.genre}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: Text(
                          "Developer : ${e?.developer}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Publisher : ${e?.publisher}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: Text(
                          "Platform : ${e?.platform}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          );
        }),
      ),
    );
  }
}
