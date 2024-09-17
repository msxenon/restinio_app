import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:restinio_app/src/core/constants/app_colors.dart';

class PriceWidget extends StatelessWidget {
  final double price;

  const PriceWidget(this.price, {super.key});
  static final _numberFormat = NumberFormat("00");
  @override
  Widget build(BuildContext context) {
    final textTheme = CupertinoTheme.of(context).textTheme;
    final int wholeNumber = price.toInt();
    final decimalNumber = _numberFormat.format((price - wholeNumber) * 100);
    final textColor = AppColors.onSurface.withOpacity(0.6);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "€$wholeNumber",
            style: textTheme.navTitleTextStyle.copyWith(
              color: textColor,
            ),
          ),
          TextSpan(
            text: ".$decimalNumber",
            style: textTheme.tabLabelTextStyle.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
