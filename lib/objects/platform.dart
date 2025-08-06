import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Platform extends PositionComponent with CollisionCallbacks {
  Platform({required Vector2 position, required Vector2 size}):super(position: position, size: size){
    debugMode = true;
    add(RectangleHitbox());
  }

  @override
  Future<void>? onLoad() async {
    add(RectangleHitbox()..collisionType= CollisionType.passive);
    add(RectangleHitbox());
    return super.onLoad();
  }
}