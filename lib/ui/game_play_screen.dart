import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  double bucketX = 0.0;
  double ballX = 0.0;
  double ballY = -1.0;
  int chances = 3;
  int score = 0;
  bool gameOver = false;
  Timer? ballTimer;

  void startGame() {
    if (ballTimer != null && ballTimer!.isActive) ballTimer!.cancel();
    resetBall();
    ballTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        ballY += 0.02;

        if (ballY >= 0.9) {
          double bucketLeft = bucketX - 0.2;
          double bucketRight = bucketX + 0.2;
          if (ballX >= bucketLeft && ballX <= bucketRight) {
            score++;
            resetBall();
          } else if (ballY > 1.1) {
            if (chances == 1) {
              timer.cancel();
              if (!gameOver) showGameOverDialog();
            } else {
              chances--;
              setState(() {});
              resetBall();
            }
          }
        }
      });
    });
  }

  void resetBall() {
    ballY = -1.0;
    ballX = Random().nextDouble() * 2 - 1; // range: -1 to 1
  }

  void moveBucket(double dx) {
    setState(() {
      bucketX += dx;
      if (bucketX < -1.0) bucketX = -1.0;
      if (bucketX > 1.0) bucketX = 1.0;
    });
  }

  void showGameOverDialog() {
    gameOver = true;
    chances = 3;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Color(0xff201736),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Game Over',
          style: GoogleFonts.pressStart2p(color: Colors.white, fontSize: 15),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your Score: $score',
              style: GoogleFonts.pressStart2p(color: Colors.white, fontSize: 15),
            ),
            SizedBox(height: 20),
            Center(
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    score = 0;
                    gameOver = false;
                  });
                  startGame();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/png/button_bg.jpg",
                      width: 200,
                    ),
                    Text(
                      "Continue",
                      style: GoogleFonts.baloo2(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  exit(0);
                },
                child: Image.asset(
                  "assets/png/exit_button.jpg",
                  width: 120,
                ),
              ),
            ),
          ],
        ),
        actions: [],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    if (ballTimer == null && ballTimer!.isActive) ballTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        moveBucket(details.delta.dx / 100);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Align(
              alignment: Alignment(ballX, ballY),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: Alignment(bucketX, 0.95),
              child: Container(
                height: 80,
                child: Image.asset("assets/png/bucket.png"),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Score: $score',
                  style: GoogleFonts.pressStart2p(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.all(12.0),
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${"🔥" * chances}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
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
