import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/reservation_entity.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';

part 'table_model.mapper.dart';

@MappableClass()
class TableModel with TableModelMappable {
  final TableEntity table;
  final TableStatus status;
  final String? bookedName;
  const TableModel({
    required this.table,
    required this.status,
    this.bookedName,
  });

  static TableModel fromEntity(
    TableEntity tableEntity,
    List<ReservationEntity> allReservations,
    String currentUserId,
    DateTime selectedDateTime,
  ) {
    final onlyThisTableReservations = allReservations
        .where((element) => element.tableId == tableEntity.id)
        .toList();

    final List<MapEntry<ReservationEntity, (DateTime, DateTime)>>
        reservationDateRanges = onlyThisTableReservations
            .map(
              (e) => MapEntry(
                e,
                (
                  e.createdAt.subtract(
                    const Duration(hours: 6),
                  ),
                  e.createdAt.add(
                    const Duration(hours: 6),
                  ),
                ),
              ),
            )
            .toList();

    final reservationEntity = reservationDateRanges.firstWhereOrNull(
      (element) {
        final startDate = element.value.$1;
        final endDate = element.value.$2;

        return selectedDateTime.isAfter(startDate) &&
            selectedDateTime.isBefore(endDate);
      },
    );

    final isReservedByCurrentUser =
        reservationEntity?.key.createdBy == currentUserId;

    return TableModel(
      table: tableEntity,
      status: isReservedByCurrentUser
          ? TableStatus.reservedByCurrentUser
          : reservationEntity != null
              ? TableStatus.reserved
              : TableStatus.available,
      bookedName:
          isReservedByCurrentUser ? reservationEntity!.key.bookedName : null,
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
