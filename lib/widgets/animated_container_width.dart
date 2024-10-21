import 'package:flutter/material.dart';

import 'animated_text.dart';

class AnimatedContainerWidth extends StatefulWidget {
  final double maxWidth;

  AnimatedContainerWidth({required this.maxWidth});

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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: widget.maxWidth).animate(_controller);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

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
          color: Colors.green,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: const Center(
              child: AnimatedText(
                text: 'Lagos Ekeja',
                size: 20,
                fontWeight: FontWeight.bold,
                duration: Duration(seconds: 5),
              ),
            ),
          ),
        );
      },
    );
  }
}
