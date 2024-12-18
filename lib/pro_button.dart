import 'package:flutter/material.dart';

class ProButton extends StatefulWidget {
  const ProButton({
    required this.onTap,
    this.onHover,
    super.key,
  });

  final VoidCallback? onTap;

  final ValueChanged<bool>? onHover;

  @override
  State<ProButton> createState() => _ProButtonState();
}

class _ProButtonState extends State<ProButton>
    with SingleTickerProviderStateMixin {
  static const _cubicCurve = Cubic(0.4, 0, 0.2, 1);

  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: _cubicCurve,
    reverseCurve: _cubicCurve.flipped,
  );

  late final _backgroundColor = ColorTween(
    begin: Colors.black,
    end: const Color(0xFF1F2937),
  ).animate(_animation);

  late final _borderWidth = Tween<double>(begin: 0, end: 4).animate(_animation);

  @override
  void dispose() {
    _controller.dispose();
    _animation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        _controller.forward();
        widget.onHover?.call(true);
      },
      onExit: (_) {
        _controller.reverse();
        widget.onHover?.call(false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE5E7EB),
                      spreadRadius: _borderWidth.value,
                    ),
                  ],
                ),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: _backgroundColor.value,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      side: BorderSide(),
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: Text(
                  'Get Dub Pro',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.429,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
