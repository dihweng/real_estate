import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedSlideText extends StatefulWidget {
  final double size;
  final FontWeight? fontWeight;
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextTheme? textTheme;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? lineHeight;
  final Duration duration;

  const AnimatedSlideText({
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
    this.duration = const Duration(milliseconds: 3000),
  }) : super(key: key);

  @override
  _AnimatedSlideTextState createState() => _AnimatedSlideTextState();
}

class _AnimatedSlideTextState extends State<AnimatedSlideText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Scale animation: starts small (like coming out of the screen) and ends at normal size
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Optional slide animation: starts slightly off center (coming out of the body)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
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
        return SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
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
          ),
        );
      },
    );
  }
}

class StaggeredTextReveal extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final Duration duration;

  const StaggeredTextReveal({
    Key? key,
    required this.text,
    this.fontSize = 20.0,
    this.color,
    this.duration = const Duration(milliseconds: 2000),
  }) : super(key: key);

  @override
  _StaggeredTextRevealState createState() => _StaggeredTextRevealState();
}

class _StaggeredTextRevealState extends State<StaggeredTextReveal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _revealAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
      animation: _revealAnimation,
      builder: (context, child) {
        return ClipRect(
          child: Stack(
            children: [
              Transform.translate(
                offset: Offset(0, 30 * (1.0 - _revealAnimation.value)),
                child: Opacity(
                  opacity: _revealAnimation.value,
                  child: Text(
                    widget.text,
                    style: GoogleFonts.nunitoSans(
                      fontSize: widget.fontSize,
                      color: widget.color ?? Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TextRevealAnimation extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final Duration duration;

  const TextRevealAnimation({
    Key? key,
    required this.text,
    this.fontSize = 24.0,
    this.color,
    this.duration = const Duration(milliseconds: 2000),
  }) : super(key: key);

  @override
  _TextRevealAnimationState createState() => _TextRevealAnimationState();
}

class _TextRevealAnimationState extends State<TextRevealAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _revealAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
      animation: _revealAnimation,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            heightFactor: _revealAnimation.value, // Adjust height factor
            child: Text(
              widget.text,
              style: GoogleFonts.nunitoSans(
                fontSize: widget.fontSize,
                color: widget.color ?? Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
