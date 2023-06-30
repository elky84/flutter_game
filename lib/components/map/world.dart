import 'package:flame/components.dart';

class World extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // 백그라운드 이미지 로드 및 사이즈 설정
    sprite = await gameRef.loadSprite('background.png');
    size = sprite!.originalSize;
  }
}
