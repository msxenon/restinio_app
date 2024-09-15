import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';

class TableWidget extends StatelessWidget {
  static const double tableMargin = 11.0;
  static const double mainAxisPadding = 11.0;
  final TableEntity table;
  const TableWidget(
    this.table, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      const height = 100.0;
      const chairPaintLength = height - (tableMargin * 2) - mainAxisPadding;
      final seatsPerSide = max(1, (table.seats - 2) ~/ 2);

      final (width, safeSeatsPerSide) = getSafeWidthAndSeatsNumber(
        seatsPerSide: seatsPerSide,
        screenWidth: screenWidth - chairPaintLength,
        chairPaintLength: chairPaintLength,
      );
      final size = Size(
        width,
        100,
      );
      return Container(
        margin: const EdgeInsets.all(20),
        constraints: BoxConstraints.tight(size),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: _TablePainter(
                seatsPerSide: safeSeatsPerSide,
                radius: const Radius.circular(5),
                tableMargin: tableMargin,
                mainAxisPadding: mainAxisPadding,
                chairLength: chairPaintLength,
                chairMargin: 2,
                color: const Color(0xffEBEFF3),
              ),
              size: size,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(text: table.tag),
                  if (safeSeatsPerSide != seatsPerSide)
                    TextSpan(
                      text: '\n\n(${table.seats} seats)',
                      style: TextStyle(
                        fontSize: 10,
                        color: CupertinoTheme.of(context).primaryColor,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  (double, int) getSafeWidthAndSeatsNumber({
    required int seatsPerSide,
    required double screenWidth,
    required double chairPaintLength,
  }) {
    final allHorizontalChairsLength = seatsPerSide * chairPaintLength +
        ((seatsPerSide + 1) * (mainAxisPadding / 2));
    double width = max(allHorizontalChairsLength + (tableMargin * 2), 100);
    while (width >= screenWidth) {
      return getSafeWidthAndSeatsNumber(
        seatsPerSide: seatsPerSide - 1,
        screenWidth: screenWidth,
        chairPaintLength: chairPaintLength,
      );
    }
    return (width, seatsPerSide);
  }
}

class _TablePainter extends CustomPainter {
  final int seatsPerSide;
  final Radius radius;
  final double tableMargin;
  final double mainAxisPadding;
  final double chairMargin;
  final double chairLength;
  final Color color;
  _TablePainter({
    required this.radius,
    required this.tableMargin,
    required this.mainAxisPadding,
    required this.seatsPerSide,
    required this.chairMargin,
    required this.chairLength,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final tableSize = _drawTable(canvas, size, paint);

    // Draw the seats
    _drawSeats(canvas, size, paint, tableSize);
  }

  RRect _drawTable(Canvas canvas, Size size, Paint paint) {
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

  void _drawSeats(
    Canvas canvas,
    Size canvasSize,
    Paint paint,
    RRect tableRect,
  ) {
    final seatPaintThickness = ((canvasSize.height - tableRect.height) / 2);

    _drawTopBottomSeats(
      canvas,
      paint,
      tableRect,
      canvasSize,
      seatPaintThickness: seatPaintThickness,
    );

    // Draw left and right seats
    _drawSideSeats(
      canvas,
      paint,
      tableRect,
      seatPaintThickness: seatPaintThickness,
    );
  }

  void _drawTopBottomSeats(
    Canvas canvas,
    Paint paint,
    RRect tableSize,
    Size canvasSize, {
    required double seatPaintThickness,
  }) {
    final xStart = tableSize.left + (mainAxisPadding / 2);

    _drawHorizontalSeats(
      canvas,
      paint,
      dx: xStart,
      dy: 0,
      seatPaintThickness: seatPaintThickness,
    );

    _drawHorizontalSeats(
      canvas,
      paint,
      dx: xStart,
      dy: tableSize.bottom,
      seatPaintThickness: seatPaintThickness,
    );
  }

  void _drawSideSeats(
    Canvas canvas,
    Paint paint,
    RRect tableSize, {
    required double seatPaintThickness,
  }) {
    // Left seat
    final halfPadding = mainAxisPadding / 2;
    final dy = tableSize.top + halfPadding;

    RRect leftSeatRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        0,
        dy,
        seatPaintThickness - chairMargin,
        chairLength,
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
        chairLength,
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
  }) {
    final bottomMargin = dy != 0 ? chairMargin : 0;
    final halfPadding = mainAxisPadding / 2;
    for (int i = 0; i < seatsPerSide; i++) {
      final itemDx = dx + (i * (chairLength + halfPadding));
      RRect seatRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          itemDx,
          dy + bottomMargin,
          chairLength,
          seatPaintThickness - chairMargin,
        ),
        radius,
      );
      canvas.drawRRect(seatRRect, paint);
    }
  }
}
