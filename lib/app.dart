import 'package:dub_pro/usage_section.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            const Positioned(
              right: 12,
              bottom: -28,
              child: FlutterLogo(
                size: 100,
                style: FlutterLogoStyle.horizontal,
              ),
            ),
            Center(
              child: DecoratedBox(
                decoration: const ShapeDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Color(0X1A171717),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      color: Color(0x0F000000),
                    ),
                  ],
                ),
                child: ClipRect(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 240),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: UsageSection(),
                    ),
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
