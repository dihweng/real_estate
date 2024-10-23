import 'package:flutter/material.dart';
import 'package:real_estate/utils/colors.dart';
import 'package:real_estate/widgets/app_text.dart';

class ExpandLocationWidget extends StatefulWidget {
  final double maxWidth;
  final String location;
  final Widget child;
  final Color backgroundColor;

  ExpandLocationWidget({
    required this.maxWidth,
    required this.location,
    required this.child,
    this.backgroundColor = Colors.transparent,
  });

  @override
  _ExpandLocationWidgetState createState() => _ExpandLocationWidgetState();
}

class _ExpandLocationWidgetState extends State<ExpandLocationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Single controller for both animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Width animation runs first, then opacity runs next
    _widthAnimation = Tween<double>(begin: 0.0, end: widget.maxWidth).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Opacity animation (starts towards the end of width animation)
    // Fade starts when 70% of the width animation is completed
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.7,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: _widthAnimation.value,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 1,
                blurStyle: BlurStyle.inner,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                // Control delayed fade-in for the text
                opacity: _fadeAnimation.value,
                child: AppText(
                  text: widget.location,
                  size: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.captionColor,
                ),
              ),
              // Child widget that will move with the expanding container
              widget.child,
            ],
          ),
        );
      },
    );
  }
}
