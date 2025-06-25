import 'package:app_games/core/injection/injection.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/dialog/app_dialog.dart';
import 'package:app_games/core/widgets/dropdown/app_dropdown.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/detail_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailHomeCategoryScreen extends StatefulWidget {
  const DetailHomeCategoryScreen({super.key});

  static Widget create() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DetailHomeViewModel(useCase: injeksi()),
        ),
      ],
      child: const DetailHomeCategoryScreen(),
    );
  }


  @override
  State<DetailHomeCategoryScreen> createState() => _DetailHomeCategoryScreenState();
}

class _DetailHomeCategoryScreenState extends State<DetailHomeCategoryScreen> {

  String? selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      // final viewModel = Provider.of<DetailHomeViewModel>(context, listen: false);
     
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailHomeViewModel>(
      builder: (context, viewModel, child) {
        return _buildPage(context, viewModel);
      },
    );
  }

   Widget _buildPage(BuildContext context,DetailHomeViewModel viewModel) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: greyBlack,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Ganti sesuai warna yang kamu mau
        ),
         backgroundColor: greyBlack,
        title: Text("Detail Game Category",style: TextStyles.body1,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            AppDropdown(
              options: [
                "MMORPG",
                "Strategy",
                "Card",
                "MOBA",
                "Shooter",
                "Fighting",
                "Action"
              ],
              hint: "Pilih...",
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
                viewModel.getGameByCategory(value);
              },
              selectedItem: selectedItem,
            ),
            const SizedBox(height: 20,),
           viewModel.isLoading ? 
           Center(child: CircularProgressIndicator(),)
            : selectedItem == null ? 
            Center(child: Text("Silahkan Pilih Category Terlebih Dahulu",style: TextStyles.body1,textAlign: TextAlign.center))
            :  viewModel.listGame.isEmpty ? 
            Center(child: Text("Game Dengan Category $selectedItem Tidak Ada",style: TextStyles.body1,textAlign: TextAlign.center),)  
            : Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(viewModel.listGame.take(30).length, (index) {
                final e = viewModel.listGame[index];
                return GestureDetector(
                  onTap: () {
                     AppDialog.showConfirmDialogChoice(
                    context: context, 
                    actions: {
                      "Detail" : (){
                        context.pushNamed(
                          "detail-game",
                          queryParameters: {'id': e?.id.toString() ?? ''},
                        );
                      },
                      "Add Favorite" : (){
                        viewModel.insertFav(e!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sukses Menambahkan Ke Favorite")));
                      }
                    }
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
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              child: Text(
                                "Platform : ${e?.platform}",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                );
              },).toList(),
            ),
          ],
        ),
      ),
    );
  }
}