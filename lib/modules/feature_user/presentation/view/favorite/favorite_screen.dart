import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Provider.of<HomeViewModel>(context,listen: false).getFav();
    },);
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context,listen: false);
    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: greyBlack,
      body: ListView.builder(
        itemCount: viewModel.listGame.length,
        itemBuilder: (context, index) {
        if (viewModel.isLoading) {
          return Center(child: CircularProgressIndicator(color: white,),);
        }
        if (viewModel.listGame.isEmpty) {
          return Center(child: Text("Tidak ada game favorit",style: TextStyles.body1,),);
        }
        final result = viewModel.listGame[index];
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                context.pushNamed("detail-game",queryParameters: {
                  "id" : result?.id.toString()
                });
              },
              child: Container(
                    width: mediaQuery,
                    margin: EdgeInsets.symmetric(horizontal: 20),
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
                          result?.thumbnail ?? "",
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Center(
                            child: Text(
                              result?.title ?? "",
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
                            "Genre : ${result?.title}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          child: Text(
                            "Developer : ${result?.developer}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Publisher : ${result?.publisher}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          child: Text(
                            "Platform : ${result?.platform}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
                const SizedBox(height: 10,)
          ],
        );
      },),
    );
  }
}