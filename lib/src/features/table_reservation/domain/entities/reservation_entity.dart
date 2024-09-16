import 'package:dart_mappable/dart_mappable.dart';
import 'package:restinio_app/src/core/domain/entities/base_entity.dart';
import 'package:restinio_app/src/features/table_reservation/domain/mappers/timestamp_mapper.dart';
part 'reservation_entity.mapper.dart';

@MappableClass(
  includeCustomMappers: [TimestampMapper()],
)
class ReservationEntity extends BaseEntity with ReservationEntityMappable {
  final DateTime createdAt;
  final String createdBy;
  final String bookedName;
  final String tableId;

  const ReservationEntity({
    required super.id,
    required this.createdAt,
    required this.createdBy,
    required this.bookedName,
    required this.tableId,
  });

  static const fromMap = ReservationEntityMapper.fromMap;
}
