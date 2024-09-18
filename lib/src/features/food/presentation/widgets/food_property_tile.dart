import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restinio_app/src/core/constants/app_colors.dart';
import 'package:restinio_app/src/core/constants/constants.dart';

class FoodPropertyTile extends StatelessWidget {
  final IconData iconDate;
  final String unit;
  final int value;
  const FoodPropertyTile({
    super.key,
    required this.iconDate,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(AppConstants.radius),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: FaIcon(iconDate, color: AppColors.primarySurface),
        ),
        const SizedBox(width: 8),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          unit,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.secondaryOnSurface,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
