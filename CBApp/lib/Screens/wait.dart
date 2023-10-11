import 'package:animated_background/animated_background.dart';
import 'package:changebackgrond_frontend/values/values.dart';
import 'package:flutter/material.dart';

class WaitScreen extends StatefulWidget {
  const WaitScreen({super.key});

  @override
  State<WaitScreen> createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> with TickerProviderStateMixin {
  bool isBlue = false;

  @override
  Widget build(BuildContext context) {
    // 테마 설정
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AnimatedBackground(
        behaviour: RacingLinesBehaviour(
          direction: LineDirection.Ltr,
          numLines: 15,
        ),
        vsync: this,
        child: Center(
          child: Text(
            StringConst.wait,
            style: textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
