import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
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
  
}
