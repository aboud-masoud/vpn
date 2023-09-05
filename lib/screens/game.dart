import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vpn/obj/item.dart';
import 'package:vpn/widgets/view.dart';

List<Item> listOfIcons = [
  Item(icon: Icons.abc),
  Item(icon: Icons.abc),
  Item(icon: Icons.ac_unit),
  Item(icon: Icons.ac_unit),
  Item(icon: Icons.access_alarm_rounded),
  Item(icon: Icons.access_alarm_rounded),
  Item(icon: Icons.dangerous),
  Item(icon: Icons.dangerous),
  Item(icon: Icons.wallet),
  Item(icon: Icons.wallet),
  Item(icon: Icons.javascript),
  Item(icon: Icons.javascript),
];

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // final storage = const FlutterSecureStorage();

  @override
  void initState() {
    // storage.write(key: "counter", value: "3");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listOfIcons.shuffle();

    return Scaffold(
      body: SafeArea(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: [
            MyView(item: listOfIcons[0]),
            MyView(item: listOfIcons[1]),
            MyView(item: listOfIcons[2]),
            MyView(item: listOfIcons[3]),
            MyView(item: listOfIcons[4]),
            MyView(item: listOfIcons[5]),
            MyView(item: listOfIcons[6]),
            MyView(item: listOfIcons[7]),
            MyView(item: listOfIcons[8]),
            MyView(item: listOfIcons[9]),
            MyView(item: listOfIcons[10]),
            MyView(item: listOfIcons[11]),
          ],
        ),
      ),
    );
  }
}
