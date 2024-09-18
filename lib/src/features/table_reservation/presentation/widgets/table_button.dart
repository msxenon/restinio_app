import 'package:flutter/cupertino.dart';
import 'package:restinio_app/src/core/constants/app_colors.dart';
import 'package:restinio_app/src/features/table_reservation/data/models/table_model.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/widgets/table_widget.dart';

class CustomPaintButton extends StatefulWidget {
  final TableModel tableModel;
  final VoidCallback onTap;
  const CustomPaintButton(this.tableModel, {required this.onTap, super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CustomPaintButtonState createState() => _CustomPaintButtonState();
}

class _CustomPaintButtonState extends State<CustomPaintButton>
    with TickerProviderStateMixin {
  bool isHovered = false;
  late Animation<double> _animation;
  late AnimationController _controller;
  static const minimumScale = 0.95;
  final isEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 30),
      lowerBound: minimumScale,
    )..value = 1;
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    switch (widget.tableModel.status) {
      case TableStatus.reserved:
        buttonColor = AppColors.secondaryOnSurface;
        break;
      case TableStatus.reservedByCurrentUser:
        buttonColor = AppColors.secondaryOnSurface;
        break;
      case TableStatus.available:
        buttonColor = CupertinoTheme.of(context).primaryColor.withOpacity(0.5);
        break;
    }

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
        _controller.reverse();
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
        _controller.forward();
      },
      child: GestureDetector(
        onTapDown: (_) {
          if (isEnabled) {
            _controller.reverse();
          }
        },
        onTapUp: (_) {
          if (isEnabled) {
            _controller.forward();
          }
        },
        onTapCancel: () {
          if (isEnabled) {
            _controller.forward();
          }
        },
        onTap: isEnabled ? widget.onTap : null,
        child: ScaleTransition(
          scale: _animation,
          child: TableWidget(widget.tableModel, buttonColor),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
