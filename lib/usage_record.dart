import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class UsageRecord extends StatefulWidget {
  const UsageRecord({
    required this.icon,
    required this.title,
    required this.usedAmount,
    required this.availableAmount,
    required this.availableProAmount,
    required this.isProAmountVisible,
    super.key,
  });

  final String icon;

  final String title;

  final int usedAmount;

  final int availableAmount;

  final int availableProAmount;

  final bool isProAmountVisible;

  @override
  State<UsageRecord> createState() => _UsageRecordState();
}

class _UsageRecordState extends State<UsageRecord>
    with SingleTickerProviderStateMixin {
  static const _cubicCurve = Cubic(0.4, 0, 0.2, 1);

  static final _numberFormatter = NumberFormat.decimalPattern('en_GB');

  late final _availableAmountColorTween = ColorTween(
    begin: const Color(0xFF525252),
    end: const Color(0xFFA3A3A3),
  );

  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );

  late final _availableAmountAnimation = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 150 / 250, curve: _cubicCurve),
    reverseCurve: const Interval(0, 150 / 250, curve: _cubicCurve).flipped,
  );

  late final _availableProAmountAnimation = CurvedAnimation(
    parent: _controller,
    curve: _cubicCurve,
    reverseCurve: _cubicCurve.flipped,
  );

  @override
  void initState() {
    super.initState();

    if (widget.isProAmountVisible) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant UsageRecord oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isProAmountVisible != widget.isProAmountVisible) {
      if (widget.isProAmountVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _availableAmountAnimation.dispose();
    _availableProAmountAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Color(0xFF404040),
          fontWeight: FontWeight.w500,
          fontSize: 12,
          height: 1.333,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  VectorGraphic(
                    loader: AssetBytesLoader(widget.icon),
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF525252),
                      BlendMode.srcIn,
                    ),
                    height: 14,
                    width: 14,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text.rich(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToLastDescent: false,
              ),
              TextSpan(
                text: '0 of ',
                children: [
                  WidgetSpan(
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _availableAmountAnimation,
                          builder: (context, _) {
                            return Text(
                              _numberFormatter.format(widget.availableAmount),
                              style: TextStyle(
                                color: _availableAmountColorTween.evaluate(
                                  _availableAmountAnimation,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedBuilder(
                              animation: _availableProAmountAnimation,
                              builder: (context, child) {
                                return FractionallySizedBox(
                                  widthFactor:
                                      _availableProAmountAnimation.value,
                                  child: child,
                                );
                              },
                              child: SizedBox(
                                height: 1,
                                width: double.infinity,
                                child: ColoredBox(
                                  color: _availableAmountColorTween.end!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              style: TextStyle(color: _availableAmountColorTween.begin),
            ),
            AnimatedBuilder(
              animation: _availableProAmountAnimation,
              builder: (context, child) {
                return Align(
                  alignment: Alignment.centerLeft,
                  heightFactor: 1,
                  widthFactor: _availableProAmountAnimation.value,
                  child: Opacity(
                    opacity: _availableProAmountAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  _numberFormatter.format(widget.availableProAmount),
                  style: const TextStyle(
                    color: Color(0xFF3662E3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
