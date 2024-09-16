import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';

abstract class TableRepository {
  static TableRepository get instance =>
      DependenciesContainer.get<TableRepository>();
  Stream<List<TableEntity>> streamAll();

  Stream<TableEntity?> stream(String tableId);
}
