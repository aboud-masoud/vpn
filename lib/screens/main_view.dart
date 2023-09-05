import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vpn/screens/game.dart';

enum VPNStatus { on, off }

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final storage = const FlutterSecureStorage();

  VPNStatus status = VPNStatus.off;

  int counter = 3;

  Timer? myTimer;

  int hours = 0;
  int minutes = 0;
  int secounds = 0;

  @override
  void initState() {
    super.initState();
  }

  startTimer() {
    counter = counter - 1;
    storage.write(key: "counter", value: counter.toString());
    myTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secounds < 59) {
        secounds = secounds + 1;
      } else {
        if (minutes < 59) {
          secounds = 0;
          minutes = minutes + 1;
        } else {
          hours = hours + 1;
          secounds = 0;
          minutes = 0;
        }
      }
      setState(() {});
    });
  }

  stopTimer() {
    if (myTimer!.isActive) {
      secounds = 0;
      minutes = 0;
      hours = 0;

      myTimer!.cancel();
    }
  }

  String timeFormatter(int value) {
    if (value < 10) {
      return "0$value";
    } else {
      return "$value";
    }
  }

  @override
  void dispose() {
    myTimer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double containerSize = MediaQuery.of(context).size.width / 2;

    return FutureBuilder<String?>(
        initialData: "3",
        future: storage.read(key: "counter"),
        builder: (context, snapshot) {
          print("snapshot.data");
          print(snapshot.data);

          if (snapshot.data != null) {
            counter = int.parse(snapshot.data!);
          }

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/logo.png",
                    width: 100,
                  ),
                  const SizedBox(height: 20),
                  // Text('Current State: $state'),
                  // Text('Current Charon State: $charonState'),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      width: containerSize,
                      height: containerSize,
                      child: TextButton(
                        child: Icon(
                          Icons.power_settings_new,
                          size: 70,
                          color: status == VPNStatus.on ? Colors.green : Colors.red,
                        ),
                        onPressed: () {
                          if (status == VPNStatus.off) {
                            if (counter != 0) {
                              status = VPNStatus.on;
                              startTimer();
                            }

                            // FlutterVpn.connectIkev2EAP(
                            //   server: "192.168.1.1",
                            //   username: "test username",
                            //   password: "test password",
                            // );
                          } else {
                            stopTimer();
                            status = VPNStatus.off;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  status == VPNStatus.on
                      ? const Text("Connected")
                      : counter == 0
                          ? const Text(
                              "You Can't Play",
                              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          : Container(),
                  status == VPNStatus.on
                      ? Text(
                          "${timeFormatter(hours)}:${timeFormatter(minutes)}:${timeFormatter(secounds)}",
                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      : counter == 0
                          ? TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                                  return const GameScreen();
                                }));
                              },
                              child: const Text("Press Here To Reset"))
                          : Container()
                ],
              ),
            ),
          );
        });
  }
}
