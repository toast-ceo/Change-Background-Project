import 'package:animated_background/animated_background.dart';
import 'package:changebackgrond_frontend/Screens/select.dart';
import 'package:changebackgrond_frontend/values/values.dart';
import 'package:flutter/material.dart';

import '../Transition/Fade.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isBlue = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, FadeRoute(page: const SelectScreen()));
    });
  }

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
            StringConst.title,
            style: textTheme.titleMedium!
                .copyWith(fontFamily: StringConst.agustina),
          ),
        ),
      ),
    );
  }
}
