import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/text.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:supermariobros/constants/globals.dart';
import 'package:supermariobros/games/super_mario_bros_game.dart';
import 'package:supermariobros/levels/level_option.dart';
import 'package:supermariobros/objects/platform.dart';

class LevelComponent extends Component with HasGameRef<SuperMario> {
  final LevelOption option;

  late Rectangle _levelBounds;

  final textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 24, // << Ubah ukuran font di sini
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.bold,
    ),
  );

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
    createPlatform(level.tileMap);
    return super.onLoad();
  }

  void createPlatform(RenderableTiledMap tileMap) {
    ObjectGroup? platformslayer = tileMap.getLayer<ObjectGroup>('Platforms');

    if (platformslayer == null) {
      throw Exception('platforms layer not found');
    }

    for (final TiledObject obj in platformslayer.objects) {
      // Platform platform = Platform(
      //   position: Vector2(obj.x, obj.y),
      //   size: Vector2(obj.width, obj.height),
      // );

      // gameRef.world.add(platform);

      // Tambahkan teks posisi ke dunia
      final positionText = TextComponent(
        text: 'x: ${obj.x.toInt()}, y: ${obj.y.toInt()}',
        textRenderer: textPaint,
        position: Vector2(obj.x, obj.y), // Di atas platform
        anchor: Anchor.bottomLeft,
      );
      gameRef.world.add(positionText);
    }
  }
}
