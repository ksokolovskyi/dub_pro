import 'package:dub_pro/pro_button.dart';
import 'package:dub_pro/usage_record.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class UsageSection extends StatefulWidget {
  const UsageSection({super.key});

  @override
  State<UsageSection> createState() => _UsageSectionState();
}

class _UsageSectionState extends State<UsageSection> {
  final _isProAmountVisible = ValueNotifier(false);

  @override
  void dispose() {
    _isProAmountVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Flexible(
              child: Text(
                'Usage',
                style: TextStyle(
                  color: Color(0xFF737373),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.429,
                ),
              ),
            ),
            SizedBox(width: 2),
            VectorGraphic(
              loader: AssetBytesLoader('assets/images/chevron_right.svg'),
              colorFilter: ColorFilter.mode(
                Color(0xFFA3A3A3),
                BlendMode.srcIn,
              ),
              height: 12,
              width: 12,
            ),
          ],
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: _isProAmountVisible,
          builder: (context, isProAmountVisible, _) {
            return UsageRecord(
              icon: 'assets/images/click.svg',
              title: 'Events',
              usedAmount: 0,
              availableAmount: 1000,
              availableProAmount: 50000,
              isProAmountVisible: isProAmountVisible,
            );
          },
        ),
        const SizedBox(height: 8),
        const _Divider(),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: _isProAmountVisible,
          builder: (context, isProAmountVisible, _) {
            return UsageRecord(
              icon: 'assets/images/link.svg',
              title: 'Links',
              usedAmount: 0,
              availableAmount: 25,
              availableProAmount: 1000,
              isProAmountVisible: isProAmountVisible,
            );
          },
        ),
        const SizedBox(height: 8),
        const _Divider(),
        const SizedBox(height: 12),
        const Text(
          'Usage will reset Jan 10, 2025',
          style: TextStyle(
            color: Color(0x66171717),
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.333,
          ),
        ),
        const SizedBox(height: 16),
        ProButton(
          onHover: (hovered) {
            _isProAmountVisible.value = hovered;
          },
          onTap: () {},
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(1)),
        color: Color(0X1A171717),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 2,
      ),
    );
  }
}
