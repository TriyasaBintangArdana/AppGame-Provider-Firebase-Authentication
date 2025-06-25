

import 'package:app_games/core/db/db.dart';
import 'package:app_games/core/dio/api_base_helper.dart';
import 'package:app_games/modules/feature_login/data/datasources/local/app_shared_preferences.dart';
import 'package:app_games/modules/feature_login/data/datasources/remote/login_remote_data_source.dart';
import 'package:app_games/modules/feature_login/data/repositories/login_repository_impl.dart';
import 'package:app_games/modules/feature_login/domain/repositories/login_repository.dart';
import 'package:app_games/modules/feature_login/domain/usecases/login_usecase.dart';
import 'package:app_games/modules/feature_login/presentation/view_model/login_view_model.dart';
import 'package:app_games/modules/feature_login/presentation/view_model/register_view_model.dart';
import 'package:app_games/modules/feature_user/data/datasources/user_data_source.dart';
import 'package:app_games/modules/feature_user/data/repositories/user_repository_impl.dart';
import 'package:app_games/modules/feature_user/domain/repositories/user_repository.dart';
import 'package:app_games/modules/feature_user/domain/usecases/user_usecase.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/detail_home_view_model.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/detail_movie/detail_game_view_model.dart';
import 'package:app_games/modules/feature_user/presentation/view_model/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final injeksi = GetIt.instance;
void injection(){
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore  firestore = FirebaseFirestore.instance;
  final FirebaseStorage  firebaseStorage = FirebaseStorage.instance;


  //Provider
  injeksi.registerFactory(() => LoginViewModel(useCase: injeksi(),sharedPreferences: injeksi()));
  injeksi.registerFactory(() => RegisterViewModel(useCase: injeksi()));
  injeksi.registerFactory(() => HomeViewModel(useCase: injeksi()));
  injeksi.registerFactory(() => DetailHomeViewModel(useCase: injeksi()));
  injeksi.registerFactory(() => DetailGameViewModel(useCase: injeksi()));

  //UseCase
  injeksi.registerLazySingleton(() => LoginUseCase(injeksi()));
  injeksi.registerLazySingleton(() => UserUseCase(injeksi()));

  //Repository
  injeksi.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(injeksi()));
  injeksi.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(injeksi()));

  //DataSource
  injeksi.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(injeksi(), injeksi()));
  injeksi.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(injeksi(), injeksi(),injeksi(),injeksi(),injeksi()));

  //Shared
  injeksi.registerLazySingleton<AppSharedPreferences>(() => AppSharedPreferencesImpl());

  //Dio
  injeksi.registerLazySingleton<ApiBaseHelper>(() => ApiBaseHelperImpl(dio: injeksi()));

  //external
  injeksi.registerLazySingleton(() => firebaseAuth);
  injeksi.registerLazySingleton(() => firestore);
  injeksi.registerLazySingleton(() => firebaseStorage);
  injeksi.registerLazySingleton(() => DBHelper.instance,);
  injeksi.registerLazySingleton(() => Dio());

}