import 'package:animated_background/animated_background.dart';
import 'package:changebackgrond_frontend/Screens/home.dart';
import 'package:flutter/material.dart';

import '../Transition/Fade.dart';
import '../values/values.dart';
import 'downloading.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AnimatedBackground(
        behaviour: RacingLinesBehaviour(
          direction: LineDirection.Ltr,
          numLines: 15,
        ),
        vsync: this,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      StringConst.download,
                      style: textTheme.titleMedium!
                          .copyWith(fontFamily: StringConst.agustina),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.download_rounded,
                          color: Colors.black87,
                          size: Sizes.ICON_SIZE_50,
                        ),
                        tooltip: 'Download',
                        onPressed: () {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (context) => const DownloadingDialog(),
                            );
                          });
                        }),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                width: MediaQuery.of(context).size.width * 1.6,
                child: IconButton(
                  icon: const Icon(
                    Icons.restart_alt_sharp,
                    color: Colors.grey,
                    size: Sizes.SIZE_30,
                  ),
                  tooltip: 'Go Home',
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context, FadeRoute(page: const HomeScreen()));
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
