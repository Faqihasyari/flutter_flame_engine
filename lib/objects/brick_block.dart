import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:supermariobros/constants/animation_configs.dart';
import 'package:supermariobros/constants/globals.dart';
import 'package:supermariobros/objects/game_block.dart';

class BrickBlock extends GameBlock {
  bool _hit = false;
  BrickBlock({required Vector2 position, required bool shouldCrumble})
    : super(
        animation: AnimationConfigs.block.brickBlockIdle(),
        position: position,
        shouldCrumble: shouldCrumble,
      );

  @override
  void hit() {
    if (shouldCrumble) {
      FlameAudio.play(Globals.breakBlockSFX);
      animation = AnimationConfigs.block.brickBlockHit();
    }
    super.hit();
  }
}
