import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interactive_ui/screens/bouncing_card/bouncing_card.dart';
import 'package:interactive_ui/screens/circle_checker/circle_checker.dart';
import 'package:interactive_ui/screens/naver_green_dot.dart/green_dot_rendering.dart';
import 'package:interactive_ui/screens/rolling_dice.dart/cube.dart';
import 'package:interactive_ui/screens/rolling_dice.dart/rolling_dice.dart';
import 'package:interactive_ui/screens/text_scale/text_scale.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent,
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Widget _navigatorButton({
    required BuildContext context,
    required Widget page,
    required String title,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.lightGreen[500],
        backgroundColor: Colors.lightGreen[200],
      ),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _navigatorButton(
            context: context,
            page: const CircleChecker(),
            title: "Circle Checker",
          ),
          _navigatorButton(
            context: context,
            page: const BouncingCard(),
            title: "Bouncing Card",
          ),
          _navigatorButton(
            context: context,
            page: const TextScale(),
            title: "글자크기 조절 인터렉션",
          ),
          _navigatorButton(
            context: context,
            page: const RollingDice(),
            title: "주사위 굴리기",
          ),
          _navigatorButton(
            context: context,
            page: const GreenDotRendering(),
            title: "네이버 GreenDot",
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.lightGreen,
        shape: CircularNotchedRectangle(),
        notchMargin: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
