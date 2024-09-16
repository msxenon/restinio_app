import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:uuid/uuid.dart';

class IdFactory {
  static IdFactory instance = DependenciesContainer.get<IdFactory>();
  final Uuid _uuid;

  IdFactory(this._uuid);

  String generate() {
    return _uuid.v1();
  }
}
