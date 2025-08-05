import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:supermariobros/constants/animation_configs.dart';
import 'package:supermariobros/constants/globals.dart';

enum MarioAnimationState { idle, walking, jumping }

class Mario extends SpriteAnimationGroupComponent<MarioAnimationState> {
  Mario({required Vector2 position, required Rectangle levelBounds})
    : super(
        position: position,
        size: Vector2(Globals.tileSize, Globals.tileSize),
        anchor: Anchor.topLeft,
      ) {
    debugMode = true;
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
