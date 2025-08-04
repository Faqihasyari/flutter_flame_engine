import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:supermariobros/constants/globals.dart';
import 'package:supermariobros/games/super_mario_bros_game.dart';
import 'package:supermariobros/levels/level_option.dart';

class LevelComponent extends Component with HasGameRef<SuperMario> {
  final LevelOption option;

  late Rectangle _levelBounds;

  LevelComponent(this.option) : super();

  @override
  Future<void> onLoad() async {
    TiledComponent level = await TiledComponent.load(
      Globals.lv_1_1,
      Vector2.all(Globals.tileSize),
    );

    gameRef.world.add(level);

    _levelBounds = Rectangle.fromPoints(
      Vector2(0, 0),
      Vector2(
            level.tileMap.map.width.toDouble(),
            level.tileMap.map.height.toDouble(),
          ) *
          Globals.tileSize,
    );
    return super.onLoad();
  }
}
