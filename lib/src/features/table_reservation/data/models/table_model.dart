import 'package:dart_mappable/dart_mappable.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/reservation_entity.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';

part 'table_model.mapper.dart';

@MappableClass()
class TableModel with TableModelMappable {
  final TableEntity table;
  final ReservationEntity? reservation;
  final TableStatus status;

  const TableModel({
    required this.table,
    this.reservation,
    required this.status,
  });

  static TableModel fromEntity(
    TableEntity tableEntity,
    ReservationEntity? reservationEntity,
    String currentUserId,
  ) {
    final isReserved = reservationEntity != null;
    final isReservedByCurrentUser =
        isReserved && reservationEntity.createdBy == currentUserId;

    return TableModel(
      table: tableEntity,
      reservation: reservationEntity,
      status: isReservedByCurrentUser
          ? TableStatus.reservedByCurrentUser
          : isReserved
              ? TableStatus.reserved
              : TableStatus.available,
    );
  }
}

enum TableStatus {
  available,
  reserved,
  reservedByCurrentUser,
}

extension TableStatusX on TableStatus {
  bool get isReserved => this == TableStatus.reserved;
  bool get isReservedByCurrentUser => this == TableStatus.reservedByCurrentUser;
  String get displayText {
    switch (this) {
      case TableStatus.available:
        return 'Available';
      case TableStatus.reserved:
        return 'Reserved';
      case TableStatus.reservedByCurrentUser:
        return 'Reserved by you';
    }
  }
}