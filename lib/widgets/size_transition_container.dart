import 'package:flutter/material.dart';

class SizeTransitionContainer extends StatefulWidget {
  final double maxSize;
  final Widget? child;
  final Duration duration;

  const SizeTransitionContainer({
    Key? key,
    required this.maxSize,
    this.child,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  _SizeTransitionContainerState createState() => _SizeTransitionContainerState();
}

class _SizeTransitionContainerState extends State<SizeTransitionContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with the provided duration
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Tween animation from 0 to the provided maxSize
    _sizeAnimation = Tween<double>(begin: 0.0, end: widget.maxSize).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animation on widget load
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
          ),
          child: widget.child,
        );
      },
    );
  }
}
