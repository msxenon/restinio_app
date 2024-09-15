import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableReservationScreen extends StatelessWidget {
  const TableReservationScreen({super.key});
  static const path = '/table_reservation';
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Table Reservation'),
      ),
      child: SafeArea(
        child: Wrap(
          children: [
            TableWidget(seatCount: 8),
            // TableWidget(seatCount: 6),
            // TableWidget(seatCount: 4),
          ],
        ),
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  final int seatCount;
  final double tableMargin;
  final double mainAxisPadding;
  const TableWidget({
    super.key,
    required this.seatCount,
    this.tableMargin = 11.0,
    this.mainAxisPadding = 11.0,
  });

  @override
  Widget build(BuildContext context) {
    final seatsPerSide = (seatCount - 2) ~/ 2;
    const height = 100.0;
    final chairPaintLength = height - (tableMargin * 2) - mainAxisPadding;
    final allHorizontalChairsLength = seatsPerSide * chairPaintLength +
        ((seatsPerSide - 1) * mainAxisPadding);

    return Container(
      margin: const EdgeInsets.all(20),
      constraints: BoxConstraints.tight(
        Size(max(allHorizontalChairsLength + (tableMargin * 2), 100), 100),
      ),
      child: CustomPaint(
        painter: TablePainter(
          seatsPerSide: seatsPerSide,
          radius: const Radius.circular(5),
          tableMargin: tableMargin,
          mainAxisPadding: mainAxisPadding,
          chairLength: chairPaintLength,
          chairMargin: 2,
        ),
      ),
    );
  }
}

class TablePainter extends CustomPainter {
  final int seatsPerSide;
  final Radius radius;
  final double tableMargin;
  final double mainAxisPadding;
  final double chairMargin;
  final double chairLength;

  TablePainter({
    required this.radius,
    required this.tableMargin,
    required this.mainAxisPadding,
    required this.seatsPerSide,
    required this.chairMargin,
    required this.chairLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.black); // Draw the table
    final tableSize = drawTable(canvas, size, paint);

    // Draw the seats
    drawSeats(canvas, size, paint, tableSize);
  }

  RRect drawTable(Canvas canvas, Size size, Paint paint) {
    final tableSize = Size(
      size.width - (tableMargin * 2),
      size.height - (tableMargin * 2),
    );
    final tableRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        tableMargin,
        tableMargin,
        tableSize.width,
        tableSize.height,
      ),
      radius,
    );
    canvas.drawRRect(tableRRect, paint);

    return tableRRect;
  }

  void drawSeats(Canvas canvas, Size canvasSize, Paint paint, RRect tableRect) {
    final seatPaintThickness = ((canvasSize.height - tableRect.height) / 2);
    final seatPaintLength = chairLength;
    // tableRect.height - mainAxisPadding;
    // Draw top and bottom seats
    drawTopBottomSeats(
      canvas,
      paint,
      tableRect,
      canvasSize,
      seatPaintThickness: seatPaintThickness,
      seatPaintLength: seatPaintLength,
    );

    // Draw left and right seats
    drawSideSeats(
      canvas,
      paint,
      tableRect,
      seatPaintThickness: seatPaintThickness,
      seatPaintLength: seatPaintLength,
    );
  }

  void drawTopBottomSeats(
    Canvas canvas,
    Paint paint,
    RRect tableSize,
    Size canvasSize, {
    required double seatPaintThickness,
    required double seatPaintLength,
  }) {
    paint.color = Colors.red.withOpacity(0.4);
    final xStart = tableSize.left + (mainAxisPadding / 2);
    // final availspaceForSeat =
    //     (tableSize.width - mainAxisPadding - mainAxisPadding);
    // if (seatsPerSide == 3) {
    final leftSeatRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        tableSize.left,
        0,
        // (seatPaintLength * seatsPerSide) + mainAxisPadding,
        tableSize.width,

        22,
      ),
      radius,
    );
    canvas.drawRRect(
        leftSeatRRect, paint..color = Colors.blue.withOpacity(0.4));
    // }
    paint.color = Colors.red.withOpacity(0.4);
    _drawHorizontalSeats(
      canvas,
      paint,
      dx: xStart,
      dy: 0,
      seatPaintThickness: seatPaintThickness,
      seatPaintLength: seatPaintLength,
    );

    _drawHorizontalSeats(
      canvas,
      paint,
      dx: xStart,
      dy: tableSize.bottom,
      seatPaintThickness: seatPaintThickness,
      seatPaintLength: seatPaintLength,
    );
  }

  void drawSideSeats(
    Canvas canvas,
    Paint paint,
    RRect tableSize, {
    required double seatPaintThickness,
    required double seatPaintLength,
  }) {
    // Left seat (only one in the middle)
    final halfPadding = mainAxisPadding / 2;
    final dy = tableSize.top + halfPadding;

    RRect leftSeatRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        0,
        dy,
        seatPaintThickness - chairMargin,
        seatPaintLength,
      ),
      radius,
    );
    canvas.drawRRect(leftSeatRRect, paint);

    // Right seat
    RRect rightSeatRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        tableSize.right + chairMargin,
        dy,
        seatPaintThickness - chairMargin,
        seatPaintLength,
      ),
      radius,
    );
    canvas.drawRRect(rightSeatRRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawHorizontalSeats(
    Canvas canvas,
    Paint paint, {
    required double dx,
    required double dy,
    required double seatPaintThickness,
    required double seatPaintLength,
  }) {
    final bottomMargin = dy != 0 ? chairMargin : 0;
    final halfPadding = mainAxisPadding / 2;
    for (int i = 0; i < seatsPerSide; i++) {
      final itemDx = dx + (i * (seatPaintLength + halfPadding));
      RRect seatRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          itemDx,
          dy + bottomMargin,
          seatPaintLength,
          seatPaintThickness - chairMargin,
        ),
        radius,
      );
      canvas.drawRRect(seatRRect, paint);
    }
  }
}
