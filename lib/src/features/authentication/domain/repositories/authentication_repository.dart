import 'package:restinio_app/src/core/di/dependencies_container.dart';

abstract class AuthenticationRepository {
  static AuthenticationRepository get instance =>
      DependenciesContainer.get<AuthenticationRepository>();

  Future<bool> loginAnonymosly();
}
