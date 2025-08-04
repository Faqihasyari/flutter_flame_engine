
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:supermariobros/games/super_mario_bros_game.dart';
import 'package:supermariobros/levels/level_option.dart';

class LevelComponent extends Component  with HasGameRef<SuperMario> {
  final LevelOption option;

  late Rectangle _levelBounds; 

  
}