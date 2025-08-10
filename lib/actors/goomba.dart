import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:supermariobros/constants/animation_configs.dart';
import 'package:supermariobros/constants/globals.dart';
import 'package:supermariobros/games/super_mario_bros_game.dart';

class Goomba extends SpriteAnimationComponent
    with HasGameRef<SuperMario>, CollisionCallbacks {
  final double _speed = 50;

  Goomba({required Vector2 position})
    : super(
        position: position,
        size: Vector2.all(Globals.tileSize),
        anchor: Anchor.topCenter,
        animation: AnimationConfigs.goomba.walking(),
      ) {
    Vector2 targetPosition = position.clone()..x -= 100;
    

    final SequenceEffect effect = SequenceEffect(
      [
        MoveToEffect(targetPosition, EffectController(speed: _speed)),
        MoveToEffect(position, EffectController(speed: _speed)),
      ],
      alternate: true,
      infinite: true,
    );

    add(effect);
  }
}
