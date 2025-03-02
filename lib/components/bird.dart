import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  //inti bird
  //initialize bird position and size

  Bird()
      : super(
          position: Vector2(birdStartX, birdStartY),
          size: Vector2(birdWidth, birdheight),
        );

  //physical world properties
  double velocity = 0;

  //load
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('bluebird.png');

    //add hit box
    add(RectangleHitbox());
  }

  //jump
  void flap() {
    velocity = jumpStrength;
  }

  //update
  @override
  Future<void> update(double dt) async {
    //apply gravity
    velocity += gravity * dt;

    //update bird's position base on current velocity
    position.y += velocity * dt;
  }

  //collition
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }

    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
