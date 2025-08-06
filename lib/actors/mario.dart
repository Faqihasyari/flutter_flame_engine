import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:supermariobros/constants/animation_configs.dart';
import 'package:supermariobros/constants/globals.dart';

enum MarioAnimationState { idle, walking, jumping }

class Mario extends SpriteAnimationGroupComponent<MarioAnimationState> {
  final double _gravity = 15;
  final Vector2 velocity = Vector2.zero();

  late Vector2 _minClamp;
  late Vector2 _maxClamp;
  Mario({required Vector2 position, required Rectangle levelBounds})
    : super(
        position: position,
        size: Vector2(Globals.tileSize, Globals.tileSize),
        anchor: Anchor.topLeft,
      ) {
    debugMode = true;

    _minClamp = levelBounds.topLeft + (size / 2);
    _maxClamp = levelBounds.bottomRight + (size / 2);

    add(CircleHitbox());

  }

  @override
  void update(double dt) {
    super.update(dt);

    if (dt > 0.05) return;

    velocityUpdate();
    positionUpdate(dt);
  }

  void velocityUpdate(){
    velocity.y += _gravity;
  }

  void positionUpdate(double dt){
    Vector2 distance = velocity * dt;

    position += distance;

    position.clamp(_minClamp, _maxClamp);
  }

  @override
  Future<void>? onLoad() async {
    final SpriteAnimation idle = await AnimationConfigs.mario.idle();

    animations = {
      MarioAnimationState.idle: idle,
    };

    current = MarioAnimationState.idle;

    return super.onLoad();
  }
}
