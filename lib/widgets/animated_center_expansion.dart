import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedContainerExpand extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final Widget child;
  final Color? bgColor;
  final BoxDecoration? decoration;
  final VoidCallback? onAnimationComplete; // Add this callback

  AnimatedContainerExpand({
    required this.maxWidth,
    required this.maxHeight,
    required this.child,
    this.decoration,
    this.bgColor,
    this.onAnimationComplete, // Add this callback to constructor
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

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: widget.maxWidth).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _heightAnimation = Tween<double>(begin: 0.0, end: widget.maxHeight).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    // Listen for animation status
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.onAnimationComplete != null) {
        // Call the this callback method when complete
        widget.onAnimationComplete!();
      }
    });

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
        return Center(
          child: Container(
            width: _widthAnimation.value,
            height: _heightAnimation.value,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}