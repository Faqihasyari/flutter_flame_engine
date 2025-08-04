import 'package:supermariobros/constants/globals.dart';

enum LevelOption {
  lv_1_1(Globals.lv_1_1, '1-1');

  const LevelOption(this.level, this.name);

  final String level;
  final String name;
}