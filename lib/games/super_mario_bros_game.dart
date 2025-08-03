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

    final mapSize = map.size; // Ukuran map (dalam satuan game)
    final screenSize =
        size; // Ukuran layar (akan tersedia setelah game layout selesai)

    // Hitung zoom biar seluruh map bisa terlihat
    final zoomX = screenSize.x / mapSize.x;
    final zoomY = screenSize.y / mapSize.y;
    final zoom = zoomX < zoomY ? zoomX : zoomY;

    final cameraComponent = CameraComponent(world: world)
      ..viewfinder.zoom =
          4.1 // atur tingkat zoom sesuai keinginanmu
      ..viewfinder.anchor = Anchor.topLeft
      ..viewfinder.position = Vector2.zero();

    print('World size: $mapSize');
    print('Screen size: $screenSize');
    print('Camera zoom: $zoom');
    
    add(cameraComponent);
    return super.onLoad();
  }
}
