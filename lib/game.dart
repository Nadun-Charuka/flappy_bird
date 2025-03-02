import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/components/pipe_manager.dart';
import 'package:flappy_bird/components/score.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  /*
  Basic Game Components:
    - bird 
    - background
    - ground
    - pipes
    - score
  */

  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;
  //load

  @override
  FutureOr<void> onLoad() {
    background = Background(size);
    add(background);

    bird = Bird();
    add(bird);

    ground = Ground();
    add(ground);

    pipeManager = PipeManager();
    add(pipeManager);

    scoreText = ScoreText();
    add(scoreText);
  }

  //tap
  @override
  void onTap() {
    bird.flap();
  }

  //score
  int score = 0;

  void incrementScore() {
    score += 1;
  }

  //game over
  bool isGameOver = false;

  void gameOver() {
    //prevent multiple game over triggers
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
      context: buildContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Your Score : $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: Text("Restart"),
          )
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    isGameOver = false;
    score = 0;
    //remove all pipe from the game
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
