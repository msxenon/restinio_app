import 'package:restinio_app/src/features/table_reservation/data/data_sources/table_data_source.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/table_repository.dart';

class TableRepositoryImpl extends TableRepository {
  final TableDataSource _dataSource;

  TableRepositoryImpl(this._dataSource);

  @override
  Stream<List<TableEntity>> streamAll() {
    return _dataSource.getFoods();
  }
}
