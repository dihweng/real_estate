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
            shape: BoxShape.circle, // Optional: adjust based on use case
            color: Colors.transparent, // Can change this based on use case
          ),
          child: widget.child, // Use the passed child widget
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';

//
// class SizeTransitionContainer extends StatefulWidget {
//   @override
//   _SizeTransitionContainerState createState() => _SizeTransitionContainerState();
// }
//
// class _SizeTransitionContainerState extends State<SizeTransitionContainer> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _sizeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//
//     // Tween animation from 0 to 50
//     _sizeAnimation = Tween<double>(begin: 0.0, end: 50.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Container(
//           width: _sizeAnimation.value,
//           height: _sizeAnimation.value,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.transparent,
//             image: DecorationImage(
//               image: AssetImage('assets/images/user.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
