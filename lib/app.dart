import 'package:flutter/material.dart';
import 'package:music_player/screens/home_screen.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Color(0XFFc23616),
            secondary: Colors.grey.shade100
          )
        ),
        home: HomeScreen());
  }
}
