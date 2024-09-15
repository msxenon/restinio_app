import 'package:flutter/cupertino.dart';
import 'package:restinio_app/src/core/async_bloc_builder.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/blocs/tables_cubit.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/widgets/table_widget.dart';

class TableReservationScreen extends StatelessWidget {
  const TableReservationScreen({super.key});
  static const path = '/table_reservation';
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Table Reservation'),
      ),
      child: SafeArea(
        child:
            AsyncBlocBuilder<TablesCubit, List<TableEntity>>((context, state) {
          return Wrap(
            children: List.generate(
              state.length,
              (index) {
                return TableWidget(state[index]);
              },
            ),
          );
        }),
      ),
    );
  }
}
