import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandLocationWidget extends StatefulWidget {
  final double maxWidth;
  final String location;
  final Color backgroundColor;
  final Widget child;
  final AnimationController controller;

  ExpandLocationWidget({
    required this.maxWidth,
    required this.location,
    required this.backgroundColor,
    required this.child,
    required this.controller,
  });

  @override
  _ExpandLocationWidgetState createState() => _ExpandLocationWidgetState();
}

class _ExpandLocationWidgetState extends State<ExpandLocationWidget> {
  late Animation<double> _widthAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Width animation
    _widthAnimation = Tween<double>(begin: 0.0, end: widget.maxWidth).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.easeInOut,
      ),
    );

    // Fade animation starts at 70% of the width animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(
          0.7,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return Container(
          constraints: BoxConstraints(
            minWidth: 0, // Allow the width to start from 0
            maxWidth: widget.maxWidth,
          ),
          width: _widthAnimation.value, // Animate width
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Fade in the text as the width expands
              Opacity(
                opacity: _fadeAnimation.value,
                child: Text(
                  widget.location,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              // Flexible widget for the image to align it dynamically
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: widget.child,  // Image, positioned at the right
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
