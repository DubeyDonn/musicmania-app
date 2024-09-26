import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';
import 'package:musiq/presentation/screens/settingsScreen/setting_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // LottieBuilder.asset(
            //   "assets/animations/Animation - 1721731246317.json",
            // ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Music Mania",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: colorList[colorIndex]),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
