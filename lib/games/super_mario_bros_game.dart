import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:supermariobros/constants/globals.dart';

class SuperMario extends FlameGame {
  late World world = World();
  @override
  Future<void> onLoad() async {
    TiledComponent map = await TiledComponent.load(
      Globals.lv_1_1,
      Vector2.all(Globals.tileSize),
    );

    world.add(map);

    var cameraComponent = CameraComponent(world: world)
    ..viewfinder.visibleGameSize = Vector2(450, 50)
    ..viewfinder.position = Vector2(0, 0)
    ..viewfinder.anchor = Anchor.topLeft
    ..viewfinder.position = Vector2(500, 0)

    return super.onLoad();
  }
}
