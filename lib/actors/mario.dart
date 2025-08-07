import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:supermariobros/constants/animation_configs.dart';
import 'package:supermariobros/constants/globals.dart';
import 'package:supermariobros/objects/platform.dart';

enum MarioAnimationState { idle, walking, jumping }

class Mario extends SpriteAnimationGroupComponent<MarioAnimationState>
    with CollisionCallbacks {
  final double _gravity = 15;
  final Vector2 velocity = Vector2.zero();

  static const double _minMoveSpeed = 125;
  static const double _maxMoveSpeed = _minMoveSpeed + 100;

  late Vector2 _minClamp;
  late Vector2 _maxClamp;

  double _jumpSpeed = 400;

  Mario({required Vector2 position, required Rectangle levelBounds})
    : super(
        position: position,
        size: Vector2(Globals.tileSize, Globals.tileSize),
        anchor: Anchor.topLeft,
      ) {
    debugMode = true;

    _minClamp = levelBounds.topLeft + (size / 2);
    _maxClamp = levelBounds.bottomRight + (size / 2);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (dt > 0.05) return;

    velocityUpdate();
    positionUpdate(dt);
  }

  void velocityUpdate() {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpSpeed, 150);
  }

  void positionUpdate(double dt) {
    Vector2 distance = velocity * dt;

    position += distance;

    position.clamp(_minClamp, _maxClamp);
  }

  @override
  Future<void>? onLoad() async {
    final SpriteAnimation idle = await AnimationConfigs.mario.idle();

    animations = {MarioAnimationState.idle: idle};

    current = MarioAnimationState.idle;

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Platform) {
      if (intersectionPoints.length == 2) {
        platformPositionCheck(intersectionPoints);
      }
    }
  }

  void platformPositionCheck(Set<Vector2> intersectionPoints) {
    final Vector2 mid =
        (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1)) / 2;

    final Vector2 collisionNormal = absoluteCenter - mid;
    double penetrationLenght = (size.x / 2) - collisionNormal.length;
    collisionNormal.normalize();

    position += collisionNormal.scaled(penetrationLenght);

    if (collisionNormal.y > 0.9) {
      velocity.y = 0;
    }
  }
}
