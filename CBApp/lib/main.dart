import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:changebackgrond_frontend/theme.dart';

import 'API/api.dart';
import 'Screens/home.dart';
import 'Screens/wait.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(const CBApp());
}

class CBApp extends StatelessWidget {
  const CBApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Post(),
        )
      ],
      child: MaterialApp(
        title: 'Change Background',
        theme: AppTheme.lightThemeData,
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomeScreen(),
          '/wait': (context) => const WaitScreen(),
        },
      ),
    );
  }
}
