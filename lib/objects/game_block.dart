import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
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
  }
}
