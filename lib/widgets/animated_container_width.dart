import 'package:flutter/material.dart';
import 'package:real_estate/utils/colors.dart';
import 'package:real_estate/widgets/app_text.dart';

class AnimatedContainerWidth extends StatefulWidget {
  final double maxWidth;
  final String location;

  AnimatedContainerWidth({
    required this.maxWidth,
    required this.location,
  });

  @override
  _AnimatedContainerWidthState createState() => _AnimatedContainerWidthState();
}

class _AnimatedContainerWidthState extends State<AnimatedContainerWidth> with SingleTickerProviderStateMixin {
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

    // Width animation runs first then opacity runs next
    _widthAnimation = Tween<double>(begin: 0.0, end: widget.maxWidth).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Opacity animation (starts towards the end of width animation)
    // Fade starts when 70% of the width animation is completed
    // Ends at the same time as the width animation
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
          width: _widthAnimation.value, // Control width expansion
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white, // Set background color to white
            borderRadius: BorderRadius.circular(8), // Add border radius
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Opacity(
            // Control delayed fade-in
            opacity: _fadeAnimation.value,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 20, color: AppColors.captionColor,),
                AppText(
                  text: widget.location,
                  size: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.captionColor
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
