import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:supermariobros/constants/animation_configs.dart';
import 'package:supermariobros/constants/globals.dart';
import 'package:supermariobros/objects/platform.dart';

enum MarioAnimationState { idle, walking, jumping }

class Mario extends SpriteAnimationGroupComponent<MarioAnimationState>
    with CollisionCallbacks, KeyboardHandler {
  final double _gravity = 15;
  final Vector2 velocity = Vector2.zero();

  final Vector2 _up = Vector2(0, -1);

  static const double _minMoveSpeed = 125;
  static const double _maxMoveSpeed = _minMoveSpeed + 100;

  double _currentSpeed = _minMoveSpeed;

  bool isFacingSpeed = true;

  int _hAxisInput = 0;

  late Vector2 _minClamp;
  late Vector2 _maxClamp;

  double _jumpSpeed = 400;

  Mario({required Rectangle levelBounds, required Vector2 position})
    : super(
        position: position,
        size: Vector2(Globals.tileSize, Globals.tileSize),
        anchor: Anchor.bottomRight,
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
    speedUpdate();
    facingDirectionUpdate();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;

    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowLeft) ? -1 : 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowRight) ? 1 : 0;

    return super.onKeyEvent(event, keysPressed);
  }

  void speedUpdate() {
    if (_hAxisInput == 0) {
      _currentSpeed = _minMoveSpeed;
    } else {
      if (_currentSpeed <= _maxMoveSpeed) {
        _currentSpeed++;
      }
    }
  }

  void facingDirectionUpdate() {
    if (_hAxisInput > 0) {
      isFacingSpeed = true;
    } else {
      isFacingSpeed = false;
    }

    if ((_hAxisInput < 0 && scale.x > 0) || (_hAxisInput > 0 && scale.x < 0)) {
      flipHorizontallyAroundCenter();
    }
  }

  void velocityUpdate() {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpSpeed, 150);

    velocity.x = _hAxisInput * _currentSpeed;
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
