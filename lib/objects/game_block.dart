import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:supermariobros/actors/mario.dart';
import 'package:supermariobros/constants/globals.dart';

class GameBlock extends SpriteAnimationComponent with CollisionCallbacks {
  late Vector2 _originalPos;

  final bool shouldCrumble;

  final double _hitDistance = 5;

  final double _gravity = 0.5;

  GameBlock({
    required Vector2 position,
    required SpriteAnimation animation,
    required this.shouldCrumble,
  }) : super(
         position: position,
         animation: animation,
         size: Vector2.all(Globals.tileSize),
       ) {
    _originalPos = position;
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (y != _originalPos.y) {
      y += _gravity;
    }
  }

  void hit() async {
    if (shouldCrumble) {
      await Future.delayed(Duration(microseconds: 250));

      add(RemoveEffect());
    } else {
      y -= _hitDistance;

      FlameAudio.play(Globals.bumpSFX);
    }
  }

  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollision(intersectionPoints, other);

    if (other is Mario) {
      if (intersectionPoints.length == 2) {
        final Vector2 mid =
            (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        if ((mid.y > position.y + size.y - 4) &&
            mid.y < position.y + size.y + 4 &&
            other.velocity.y < 0) {
              other.velocity.y = 0;
              hit();
            }

            other.platformPositionCheck(intersectionPoints);
      }
    }
  }
}
