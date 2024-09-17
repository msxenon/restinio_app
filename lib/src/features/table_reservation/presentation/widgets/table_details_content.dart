import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/core/async_bloc_builder.dart';
import 'package:restinio_app/src/core/navigation/app_router.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:restinio_app/src/features/table_reservation/data/models/table_model.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/reservation_repository.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/table_repository.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/blocs/table_details_cubit.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/widgets/table_widget.dart';

class TableDetailsContent extends StatelessWidget {
  const TableDetailsContent({
    super.key,
    required this.date,
    required this.tableId,
    required this.onNavigateToReservation,
  });
  final String tableId;
  final int date;
  final VoidCallback onNavigateToReservation;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TableDetailsCubit(
          TableRepository.instance,
          ReservationRepository.instance,
          AuthenticationRepository.instance,
          DateTime.fromMillisecondsSinceEpoch(date),
          tableId,
        );
      },
      child: AsyncBlocBuilder<TableDetailsCubit, TableModel?>(
        (context, model) {
          if (model == null) {
            return const Center(child: Text('No data'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TableWidget(
                      model,
                      CupertinoTheme.of(context).primaryColor,
                      skipOverlays: true,
                    ),
                  ),
                ],
              ),
              CupertinoListTile(
                trailing: Text('${model.table.seats.toString()} chairs'),
                title: Text('Table #${model.table.tag}'),
              ),
              CupertinoListTile(
                subtitle: const Text('Status'),
                title: Text(
                  model.status.displayText,
                ),
              ),
              if (model.status == TableStatus.available)
                CupertinoButton.filled(
                  onPressed: onNavigateToReservation,
                  child: const Text('Book it now'),
                ),
              if (model.status == TableStatus.reservedByCurrentUser)
                CupertinoButton(
                  child: const Text(
                    'Cancel reservation',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    context
                        .read<TableDetailsCubit>()
                        .cancelReservation(model.table.id);
                    AppRouter.instance.pop();
                  },
                ),
              const SizedBox(height: 16)
            ],
          );
        },
      ),
    );
  }
}
