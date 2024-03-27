import 'package:bloc_goroute/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloc_goroute/core/secrets/app_secrets.dart';
import 'package:bloc_goroute/features/auth/data/data_sources.dart/auth_remote_data_source.dart';
import 'package:bloc_goroute/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bloc_goroute/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_goroute/features/auth/domain/usecases/current_user.dart';
import 'package:bloc_goroute/features/auth/domain/usecases/user_sign_up.dart';
import 'package:bloc_goroute/features/auth/domain/usecases/user_signin.dart';
import 'package:bloc_goroute/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    //Datasource
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()))
    // reposittory
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImplementation(serviceLocator()))
    //usecases
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(
          userSignUp: serviceLocator(),
          userLogin: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
}
