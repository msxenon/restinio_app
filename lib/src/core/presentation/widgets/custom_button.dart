import 'package:flutter/cupertino.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;
  const CustomButton({required this.child, required this.onTap, super.key});
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with TickerProviderStateMixin {
  bool isHovered = false;
  late Animation<double> _animation;
  late AnimationController _controller;
  static const minimumScale = 0.95;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      lowerBound: minimumScale,
    )..value = 1;
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onTap != null;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onTap,
      child: AbsorbPointer(
        child: MouseRegion(
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
            child: ScaleTransition(
              scale: _animation,
              child: widget.child,
            ),
          ),
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
