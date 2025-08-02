import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:supermariobros/constants/globals.dart';
import 'package:supermariobros/constants/sprite_sheets.dart';
import 'package:supermariobros/games/super_mario_bros_game.dart';

final SuperMario _superMarioBrosGame = SuperMario();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pre-load sprite sheets.
  await SpriteSheets.load();

  await FlameAudio.audioCache.loadAll([
    Globals.jumpSmallSFX,
    Globals.pauseSFX,
    Globals.bumpSFX,
    Globals.powerUpAppearsSFX,
    Globals.breakBlockSFX,
  ]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(game: _superMarioBrosGame),
    ),
  );
}
