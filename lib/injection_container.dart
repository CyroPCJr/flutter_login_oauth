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
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(sl()),
  );

  final googleSignIn = GoogleSignIn.instance;
  await googleSignIn.initialize();

  sl.registerSingleton<GoogleSignIn>(googleSignIn);

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl<FirebaseAuth>(),
      googleSignIn: sl<GoogleSignIn>(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: sl<AuthRemoteDataSource>(),
      local: sl<AuthLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton(() => LoginWithEmail(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LoginWithGoogle(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetCurrentUser(sl<AuthRepository>()));
  sl.registerLazySingleton(() => Logout(sl<AuthRepository>()));

  sl.registerFactory(
    () => AuthViewModel(
      loginWithEmailUseCase: sl<LoginWithEmail>(),
      loginWithGoogleUseCase: sl<LoginWithGoogle>(),
      getCurrentUserUseCase: sl<GetCurrentUser>(),
      logoutUseCase: sl<Logout>(),
    ),
  );
}
