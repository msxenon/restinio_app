import 'package:dart_mappable/dart_mappable.dart';
import 'package:restinio_app/src/core/domain/entities/base_entity.dart';
part 'table_entity.mapper.dart';

@MappableClass()
class TableEntity extends BaseEntity with TableEntityMappable {
  final String tag;
  final int seats;

  const TableEntity({
    required super.id,
    required this.tag,
    required this.seats,
  });

  static const fromMap = TableEntityMapper.fromMap;
}
