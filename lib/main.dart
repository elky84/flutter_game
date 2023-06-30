// ref https://opengameart.org/content/alternate-lpc-character-sprites-george

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/main_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainGamePage(),
    );
  }
}

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  State<MainGamePage> createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: MainGame()),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccount()),
                );
                if (result != null) {
                  final game = MainGame(); // GameWidget 대신 MainGame 클래스 사용
                  game.setPlayerName(
                      result); // MainGame 클래스의 _playerName 변수 업데이트
                }
              },
              backgroundColor: Colors.black.withOpacity(0.15),
              child: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateAccount extends StatelessWidget {
  final _nameController = TextEditingController(); // 컨트롤러 생성

  CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController, // 컨트롤러 등록
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context, _nameController.text);
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    hintText: 'Your name?',
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
