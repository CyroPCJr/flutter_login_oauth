import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttter_login_oauth/core/services/secure_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'feature/auth/data/datasources/auth_local_datasource.dart';
import 'feature/auth/data/datasources/auth_remote_datasource.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/repositories/auth_repository.dart';
import 'feature/auth/domain/usecases/get_current_user.dart';
import 'feature/auth/domain/usecases/login_with_email.dart';
import 'feature/auth/domain/usecases/login_with_google.dart';
import 'feature/auth/domain/usecases/logout.dart';
import 'feature/auth/presentation/viewmodels/auth_viewmodel.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn);
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => SecureStorageService(sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton(() => LoginWithEmail(sl()));
  sl.registerLazySingleton(() => LoginWithGoogle(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  sl.registerFactory(
    () => AuthViewModel(
      loginWithEmailUseCase: sl(),
      loginWithGoogleUseCase: sl(),
      getCurrentUserUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
}