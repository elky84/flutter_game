import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

class Player extends SpriteAnimationComponent with KeyboardHandler, HasGameRef {
  Player()
    : super(
      size: Vector2.all(50),
      anchor: Anchor.center
    );

  // 케릭터 에니메이션에 대한 속도
  final double _animationSpeed = 0.15;

  // 케릭터 이동에 대한 속도
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 300;

  // 케릭터의 이동 방향
  int horizontalDirection = 0;
  int verticalDirection = 0;

  // 케릭터 이동 방향에 따른 에니메이션
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  // 케릭터 이름
  late TextComponent _nameComponent;

  // Load 됐을 때,
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 이름생성
    _nameComponent = TextComponent(text: 'Player')
      ..anchor = Anchor.topCenter
      ..x = size.x / 2
      ..y = -35;
    add(_nameComponent);

    // 케릭터 에니메이션 설정
    await _loadAnimations();

    // 케릭터 생성 후 스탠딩 모션을 default로
    animation = _standingAnimation;
  }

  // Update 될 때,
  @override
  void update(double dt) {
    // x, y 축 이동속도 계산
    velocity.x = horizontalDirection * moveSpeed;
    velocity.y = verticalDirection * moveSpeed;

    // 플레이어 이동 (dt는 마지막 프레임으로 부터 경가된 시간[초])
    position += velocity * dt;

    super.update(dt);
  }

  // 에니메이션 로드
  Future<void> _loadAnimations() async {
    final game = FlameGame();
    final spriteSheet = SpriteSheet(
      image: await game.images.load('player_spritesheet.png'),
      // srcSize : SpriteSheet에서 각 스프라이트의 크기를 지정하는 속성
      // player_spritesheet.png 이미지의 각 스프라이트가 29x32로 자르도록 지정
      srcSize: Vector2(29.0, 32.0),
    );

    // 위로 움직일 때의 케릭터 에니메이션
    _runUpAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      to: 4,
    );

    // 아래로 움직일 때의 케릭터 에니메이션
    _runDownAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 4,
    );

    // 왼쪽으로 움직일 때의 케릭터 에니메이션
    _runLeftAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: _animationSpeed,
      to: 4,
    );

    // 오른쪽으로 움직일 때의 케릭터 에니메이션
    _runRightAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: _animationSpeed,
      to: 4,
    );

    // 가만히 서있을 때의 케릭터 에니메이션
    _standingAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 1,
    );
  }

  // 키보드 이벤트 처리
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    verticalDirection = 0;
    bool keyPressed = false;

    // 움직임에 따라 에니메이션 변경
    // 상 화살표가 눌린 경우 verticalDirection +1
    if(keysPressed.contains(LogicalKeyboardKey.arrowUp)){
      verticalDirection -= 1;
      animation = _runUpAnimation;
      keyPressed = true;
    }

    // 하 화살표가 눌린 경우 verticalDirection -1
    if(keysPressed.contains(LogicalKeyboardKey.arrowDown)){
      verticalDirection += 1;
      animation = _runDownAnimation;
      keyPressed = true;
    }

    // 좌 화살표가 눌린 경우 horizontalDirection -1
    if(keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
      horizontalDirection -= 1;
      animation = _runLeftAnimation;
      keyPressed = true;
    }

    // 우 화살표가 눌린 경우 horizontalDirection +1
    if(keysPressed.contains(LogicalKeyboardKey.arrowRight)){
      horizontalDirection += 1;
      animation = _runRightAnimation;
      keyPressed = true;
    }

    // 키가 눌리지 않았을 때
    if (!keyPressed) {
      horizontalDirection = 0;
      verticalDirection = 0;
      animation = _standingAnimation;
    }

    return true;
  }

  void setName(String name) {
    _nameComponent.text = name;
  }
}