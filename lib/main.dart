import 'package:flutter/material.dart';
import 'package:interactive_ui/screens/circle_checker.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: App(),
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
