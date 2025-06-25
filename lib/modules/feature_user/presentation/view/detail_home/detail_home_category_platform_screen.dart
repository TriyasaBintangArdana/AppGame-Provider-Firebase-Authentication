import 'package:app_games/core/injection/injection.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/core/widgets/dialog/app_dialog.dart';
import 'package:app_games/core/widgets/dropdown/app_dropdown.dart';
import 'package:app_games/core/widgets/text_style.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/detail_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailHomeCategoryPlatformScreen extends StatefulWidget {
  const DetailHomeCategoryPlatformScreen({super.key});

  static Widget create() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DetailHomeViewModel(useCase: injeksi()),
        ),
      ],
      child: const DetailHomeCategoryPlatformScreen(),
    );
  }

  @override
  State<DetailHomeCategoryPlatformScreen> createState() =>
      _DetailHomeCategoryPlatformScreenState();
}

class _DetailHomeCategoryPlatformScreenState
    extends State<DetailHomeCategoryPlatformScreen> {
  String? selectedPlatform;
  String? selectedCategory;
  String textValue = "";
  @override
  void initState() {
    super.initState();
    selectedValue();
  }

  selectedValue() {
    final viewModel = Provider.of<DetailHomeViewModel>(context, listen: false);
    if (selectedCategory == "" ||
        selectedCategory == null && selectedPlatform == null ||
        selectedPlatform == "") {
      textValue = "Silahkan Pilih Category & Platform Terlebih Dahulu";
    } else if (selectedCategory == "" || selectedCategory == null) {
      textValue = "Silahkan Pilih Category Terlebih Dahulu";
    } else if (selectedPlatform == null || selectedPlatform == "") {
      textValue = "Silahkan Pilih Platform Terlebih Dahulu";
    } else {
      viewModel.getAllGameByCategoryAndPlatform(
        selectedCategory,
        selectedPlatform,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailHomeViewModel>(
      builder: (context, viewModel, child) {
        return _buildPage(context, viewModel);
      },
    );
  }

  Widget _buildPage(BuildContext context, DetailHomeViewModel viewModel) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: greyBlack,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Ganti sesuai warna yang kamu mau
        ),
        backgroundColor: greyBlack,
        title: Text("Detail Game Platform & Category", style: TextStyles.body1),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: mediaQuery * 0.42,
                  child: AppDropdown(
                    options: [
                      "MMORPG",
                      "Strategy",
                      "Card",
                      "MOBA",
                      "Shooter",
                      "Fighting",
                      "Action",
                    ],
                    hint: "Category...",
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                      selectedValue();
                    },
                    selectedItem: selectedCategory,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: mediaQuery * 0.42,
                  child: AppDropdown(
                    options: ["browser", "pc"],
                    hint: "Platform...",
                    onChanged: (value) {
                      setState(() {
                        selectedPlatform = value;
                      });
                      selectedValue();
                    },
                    selectedItem: selectedPlatform,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            viewModel.isLoading
                ? Center(child: CircularProgressIndicator())
                : selectedCategory == null && selectedPlatform == null
                ? Center(
                  child: Text(
                    textValue,
                    style: TextStyles.body1,
                    textAlign: TextAlign.center,
                  ),
                )
                : selectedCategory == null
                ? Center(
                  child: Text(
                    textValue,
                    style: TextStyles.body1,
                    textAlign: TextAlign.center,
                  ),
                )
                : selectedPlatform == null
                ? Center(
                  child: Text(
                    textValue,
                    style: TextStyles.body1,
                    textAlign: TextAlign.center,
                  ),
                )
                : viewModel.listGame.isEmpty
                ? Center(
                  child: Text(
                    "Game Dengan Platform $selectedCategory & Category $selectedPlatform Tidak Ada",
                    style: TextStyles.body1,
                    textAlign: TextAlign.center,
                  ),
                )
                : Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      List.generate(viewModel.listGame.take(30).length, (
                        index,
                      ) {
                        final e = viewModel.listGame[index];
                        return GestureDetector(
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
                                      content: Text(
                                        "Sukses Menambahkan Ke Favorite",
                                      ),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
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
                        );
                      }).toList(),
                ),
          ],
        ),
      ),
    );
  }
}
