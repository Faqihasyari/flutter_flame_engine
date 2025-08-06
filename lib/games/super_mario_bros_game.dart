import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:supermariobros/constants/globals.dart';
import 'package:supermariobros/levels/level_component.dart';
import 'package:supermariobros/levels/level_option.dart';

class SuperMario extends FlameGame {
  late CameraComponent cameraComponent;
  final World world = World();
  LevelComponent? _currentLevel;

  @override
  Future<void> onLoad() async {
    final cameraComponent = CameraComponent(world: world)
      ..viewfinder.zoom =
          3.0 // atur tingkat zoom sesuai keinginanmu
      ..viewfinder.anchor = Anchor.topLeft
      ..viewfinder.position = Vector2.zero();
    addAll([world, cameraComponent]);

    loadLevel(LevelOption.lv_1_1);
    return super.onLoad();
  }

  void loadLevel(LevelOption option) {
    _currentLevel?.removeFromParent();
    _currentLevel = LevelComponent(option);
    add(_currentLevel!);
  }
}
