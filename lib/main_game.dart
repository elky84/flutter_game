import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'components/player/player.dart';
import 'components/map/world.dart';

// FlameGame Extends
class MainGame extends FlameGame with HasKeyboardHandlerComponents {
  final Player _player = Player();
  final World _world = World();

  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(Vector2(1280, 720));

    add(_world);
    add(_player);

    // world 객체 생성 대기, 케릭터 맵 중앙에 세팅
    await _world.onLoad();

    _player.position = Vector2(
      (_world.size.x / 2) - (_player.size.x / 2),
      (_world.size.y / 2) - (_player.size.y / 2),
    );

    camera.followComponent(
      _player,
      worldBounds: Rect.fromLTWH(
        0,
        0,
        (_world.size.x),
        (_world.size.y),
      ),
    );
  }

  void setPlayerName(String name) {
    _player.setName(name);
  }
}
