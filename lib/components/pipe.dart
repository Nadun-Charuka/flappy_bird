import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;

  bool scored = false;

  Pipe(Vector2 posotion, Vector2 size, {required this.isTopPipe})
      : super(position: posotion, size: size);

  //load
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');

    add(RectangleHitbox());
  }

  //update
  @override
  void update(double dt) {
    position.x -= groundScrollingSpeed * dt;

    //check if bird pass the pipe
    if (!scored && position.x + size.x < gameRef.bird.position.x) {
      scored = true;
      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }

    //remove pipe if it goes off the screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
