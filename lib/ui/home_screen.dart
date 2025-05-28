import 'dart:io'; // Needed for exit(0)

import 'package:ex3/ui/game_play_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void startGame(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GamePlayScreen()));
  }

  void exitGame() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff201736),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome to the Bucket Game',
                textAlign: TextAlign.center,
                style: GoogleFonts.pressStart2p(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => startGame(context),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/png/button_bg.jpg",
                    width: 200,
                  ),
                  Text(
                    "Start",
                    style: GoogleFonts.baloo2(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: exitGame,
              child: Image.asset(
                "assets/png/exit_button.jpg",
                width: 150,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Developed by zakria khan\nStudent ID : 1276584\n',
                textAlign: TextAlign.center,
                style: GoogleFonts.pressStart2p(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
