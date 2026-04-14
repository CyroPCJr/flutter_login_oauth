import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> loginWithGoogle();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebase(user);
  }

  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Usuário não encontrado após login.');
    }

    return UserModel.fromFirebase(user);
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      final GoogleSignInAccount account = await googleSignIn.authenticate();

      final authentication = account.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Falha ao autenticar com Google.');
      }

      return UserModel.fromFirebase(user);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw Exception('Login com Google cancelado.');
      }
      throw Exception('Erro no login com Google: ${e.description}');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
