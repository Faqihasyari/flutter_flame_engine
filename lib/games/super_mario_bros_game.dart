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

    await world.add(map);
    await add(world);

    var cameraComponent = CameraComponent(world: world)
      ..viewfinder.zoom =
          3.0 // atur tingkat zoom sesuai keinginanmu
      ..viewfinder.anchor = Anchor.topLeft
      ..viewfinder.position = Vector2.zero();

    print('World size: ${map.size}');
    print('Camera zoom before set: ${cameraComponent.viewfinder.zoom}');

    addAll([world, cameraComponent]);

    return super.onLoad();
  }
}
