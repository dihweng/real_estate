import 'package:flutter/material.dart';

class AnimatedContainerNoOpacity extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final Widget child;
  final Color? bgColor;
  final BoxDecoration? decoration;
  final bool isCircle; // Prop to make circular shape

  AnimatedContainerNoOpacity({
    required this.maxWidth,
    required this.maxHeight,
    required this.child,
    this.decoration,
    this.bgColor,
    this.isCircle = false, // Default value for non-circular shape
  });

  @override
  _AnimatedContainerNoOpacityState createState() => _AnimatedContainerNoOpacityState();
}

class _AnimatedContainerNoOpacityState extends State<AnimatedContainerNoOpacity>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: widget.maxWidth).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _heightAnimation = Tween<double>(begin: 0.0, end: widget.maxHeight).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
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
        return Center(
          child: ClipRRect(
            borderRadius: widget.isCircle
                ? BorderRadius.zero
                : BorderRadius.circular(8), // Rounded corners for non-circular containers
            child: Container(
              width: _widthAnimation.value,
              height: _heightAnimation.value,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: widget.isCircle
                  ? BoxDecoration(
                color: widget.bgColor,
                shape: BoxShape.circle, // Circular shape
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 0),
                  ),
                ],
              )
                  : BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(8), // Regular radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: SingleChildScrollView(
                  // Add SingleChildScrollView to prevent overflow
                  child: widget.child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
