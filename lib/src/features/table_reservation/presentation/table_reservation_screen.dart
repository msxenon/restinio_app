import 'package:flutter/cupertino.dart';

class TableReservationScreen extends StatelessWidget {
  const TableReservationScreen({super.key});
  static const path = '/table_reservation';
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Table Reservation'),
      ),
      child: Center(
        child: Text('Table Reservation'),
      ),
    );
  }
}
