import 'package:firebase_auth/firebase_auth.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  
  AuthenticationRepositoryImpl(this._firebaseAuth);
  
  @override
  String? get userId => _firebaseAuth.currentUser?.uid;

  @override
  Future<bool> loginAnonymosly() async {
    await _firebaseAuth.signInAnonymously();
    return true;
  }

}
