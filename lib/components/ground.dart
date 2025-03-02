import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  //init
  Ground() : super();

  //load
  @override
  FutureOr<void> onLoad() async {
    //set size and position(2x widht for infinite scrolling)
    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    //load
    sprite = await Sprite.load('ground.png');

    //add collision box
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    //move ground to left
    position.x -= groundScrollingSpeed * dt;

    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
