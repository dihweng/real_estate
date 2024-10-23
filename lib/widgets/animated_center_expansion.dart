import 'package:flutter/material.dart';
import 'package:real_estate/utils/colors.dart';

class AnimatedContainerExpand extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final Widget child;
  final Color? bgColor;
  final BoxDecoration? decoration;

  AnimatedContainerExpand({
    required this.maxWidth,
    required this.maxHeight,
    required this.child,
    this.decoration,
    this.bgColor,
  });

  @override
  _AnimatedContainerExpandState createState() => _AnimatedContainerExpandState();
}

class _AnimatedContainerExpandState extends State<AnimatedContainerExpand> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _heightAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Width animation (from 0 to maxWidth)
    _widthAnimation = Tween<double>(begin: 0.0, end: widget.maxWidth).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Height animation (from 0 to maxHeight)
    _heightAnimation = Tween<double>(begin: 0.0, end: widget.maxHeight).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Opacity animation (fade in during the expansion)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.7, // Starts fading in after 70% of the animation
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
        return Center( // Centering the animation to expand from the middle
          child: Container(
            width: _widthAnimation.value,  // Animate width
            height: _heightAnimation.value, // Animate height
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: widget.bgColor,  // Background color
              borderRadius: BorderRadius.circular(8),  // Add border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),  // Shadow color
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Opacity(
              // Control delayed fade-in
              opacity: _fadeAnimation.value,
              child: widget.child, // Use the passed child widget
            ),
          ),
        );
      },
    );
  }
}
