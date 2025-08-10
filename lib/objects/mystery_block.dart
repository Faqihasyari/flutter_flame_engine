import 'package:flame/components.dart';
import 'package:supermariobros/constants/animation_configs.dart';
import 'package:supermariobros/objects/game_block.dart';

class MysteryBlock extends GameBlock {
  bool _hit = false;
  MysteryBlock({required Vector2 position}):super(
    animation: AnimationConfigs.block.mysteryBlockIdle(),
    position: position,
    shouldCrumble: false,
  );

  @override
  void hit(){
    if (!_hit) {
      _hit = true;

      animation = AnimationConfigs.block.mysteryBlockHit();
    }
    super.hit();
  }
}