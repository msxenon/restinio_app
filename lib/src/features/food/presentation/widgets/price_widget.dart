import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class PriceWidget extends StatelessWidget {
  final double price;

  const PriceWidget(this.price, {super.key});
  static final _numberFormat = NumberFormat("00");
  @override
  Widget build(BuildContext context) {
    final int wholeNumber = price.toInt();
    final decimalNumber = _numberFormat.format((price - wholeNumber) * 100);
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
          text: "€$wholeNumber",
          style: TextStyle(
            color: CupertinoTheme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: ".$decimalNumber",
          style: TextStyle(
            color: CupertinoTheme.of(context).primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 10,
          ),
        ),
      ],
    ));
  }
}
