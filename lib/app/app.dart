import 'package:flutter/material.dart';
import 'package:fokus/app/enums/timer_type.dart';
import 'package:fokus/app/pages/home_page.dart';
import 'package:fokus/app/pages/timer_page.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => HomePage(),
        '/timer': (context) => TimerPage(
          timerType: ModalRoute.of(context)!.settings.arguments as TimerType,
        ),
      },
      title: 'Fokus',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.unboundedTextTheme(),
      ),
      initialRoute: '/home',
    );
  }
}
