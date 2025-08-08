import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/text.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:supermariobros/actors/mario.dart';
import 'package:supermariobros/constants/globals.dart';
import 'package:supermariobros/games/super_mario_bros_game.dart';
import 'package:supermariobros/levels/level_option.dart';
import 'package:supermariobros/objects/platform.dart';

class LevelComponent extends Component with HasGameRef<SuperMario> {
  final LevelOption option;

  late Rectangle _levelBounds;

  late Mario _mario;

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
    createActors(level.tileMap);
    createPlatform(level.tileMap);
    _setupCamera();

    return super.onLoad();
  }

  void createActors(RenderableTiledMap tileMap) {
    ObjectGroup? actorsLayer = tileMap.getLayer<ObjectGroup>('Actors');

    if (actorsLayer == null) {
      throw Exception('Actors layer not found');
    }

    for (final TiledObject obj in actorsLayer.objects) {
      switch (obj.name) {
        case 'Mario':
          _mario = Mario(
            position: Vector2(obj.x, obj.y),
            levelBounds: _levelBounds,
          );
          gameRef.world.add(_mario);
          break;
        default:
          break;
      }
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

  void createPlatform(RenderableTiledMap tileMap) {
    ObjectGroup? platformslayer = tileMap.getLayer<ObjectGroup>('Platforms');

    if (platformslayer != null) {
      for (final TiledObject platformObject in platformslayer.objects) {
        final platform = Platform(
          position: Vector2(platformObject.x, platformObject.y),
          size: Vector2(platformObject.width, platformObject.height),
        );
        gameRef.world.add(platform);
      }
    }
    if (platformslayer == null) {
      throw Exception('platforms layer not found');
    }

    for (final TiledObject obj in platformslayer.objects) {
      final positionText = TextComponent(
        text: 'x: ${obj.x.toInt()}, y: ${obj.y.toInt()}',
        textRenderer: textPaint,
        position: Vector2(obj.x, obj.y - 20), // Di atas platform
        anchor: Anchor.center,
      );
      gameRef.world.add(positionText);
    }
  }

  void _setupCamera() {
    gameRef.cameraComponent.follow(_mario, maxSpeed: 4000);
    gameRef.cameraComponent.viewfinder
      ..anchor = Anchor(0.1, 0.1)
      ..zoom = 3.5; // 🔍 Tambahkan zoom di sini
    gameRef.cameraComponent.setBounds(
      Rectangle.fromPoints(_levelBounds.topRight, _levelBounds.topLeft),
    );
  }
}
