import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedText extends StatefulWidget {
  final double size;
  final FontWeight? fontWeight;
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextTheme? textTheme;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? lineHeight;
  final Duration duration; // Animation duration

  const AnimatedText({
    Key? key,
    this.size = 16.0,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.left,
    required this.text,
    this.textTheme,
    this.overflow,
    this.maxLines,
    this.lineHeight,
    this.color,
    this.duration = const Duration(milliseconds: 4000), // Default fade duration
  }) : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

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
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Text(
            widget.text,
            textAlign: widget.textAlign,
            overflow: widget.overflow,
            softWrap: true,
            maxLines: widget.maxLines,
            textScaleFactor: 1.0,
            style: GoogleFonts.nunitoSans(
              color: widget.color,
              fontSize: widget.size,
              fontWeight: widget.fontWeight,
              height: widget.lineHeight,
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        );
      },
    );
  }
}
