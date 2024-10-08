import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/core/async_bloc_builder.dart';
import 'package:restinio_app/src/core/navigation/routes.dart';
import 'package:restinio_app/src/core/utilities/extensions/date_time_extensions.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:restinio_app/src/features/table_reservation/data/models/table_model.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/reservation_repository.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/table_repository.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/blocs/tables_screen_cubit.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/widgets/table_button.dart';

class TableReservationScreenStep2 extends StatelessWidget {
  const TableReservationScreenStep2(this.selectedDateTime, {super.key});
  final DateTime selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Table Reservation for ${selectedDateTime.toHumanReadable()}',
        ),
        previousPageTitle: '',
      ),
      child: SafeArea(
        child: BlocProvider<TablesCubit>(
          create: (context) => TablesCubit(
            TableRepository.instance,
            ReservationRepository.instance,
            AuthenticationRepository.instance,
            selectedDateTime,
          ),
          child: AsyncBlocBuilder<TablesCubit, List<TableModel>>(
            (context, state) {
              return SingleChildScrollView(
                child: Wrap(
                  children: List.generate(
                    state.length,
                    (index) {
                      final tableModel = state[index];
                      return CustomPaintButton(
                        tableModel,
                        onTap: () {
                          TableReservationStep3Route(
                            date: selectedDateTime.millisecondsSinceEpoch,
                            tableId: tableModel.table.id,
                          ).go(context);
                        },
                      );
                    },
                  ),
                ),
              );
            },
            dummyLoadingState: List.generate(
              20,
              (index) => TableModel.dummy(index),
            ),
          ),
        ),
      ),
    );
  }
}
