import 'package:flutter/material.dart';

class ExpandZeroMaxContainer extends StatefulWidget {
  @override
  _ExpandZeroMaxContainerState createState() => _ExpandZeroMaxContainerState();
}

class _ExpandZeroMaxContainerState extends State<ExpandZeroMaxContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Tween animation from 0 to 50
    _sizeAnimation = Tween<double>(begin: 0.0, end: 50.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
          width: _sizeAnimation.value,
          height: _sizeAnimation.value,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('assets/images/user.png'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
