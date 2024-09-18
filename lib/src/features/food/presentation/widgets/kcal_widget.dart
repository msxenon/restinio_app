import 'package:flutter/cupertino.dart';
import 'package:restinio_app/src/core/constants/app_colors.dart';

class KcalWidget extends StatelessWidget {
  final int kcal;
  const KcalWidget(this.kcal, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          CupertinoIcons.circle_fill,
          color: AppColors.secondaryOnSurface,
          size: 5,
        ),
        const SizedBox(width: 4),
        Text(
          '$kcal Kcal',
          style: const TextStyle(
            color: AppColors.secondaryOnSurface,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
