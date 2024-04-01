import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:midterm1/constants/global.dart';
import 'package:midterm1/scrrens/gameplay.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlameAudio.bgm.play(Globals.bgmusic);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FlameAudio.bgm.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg9.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Text('Engkanto Escape: Dodge Game',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.red.shade400,fontSize: 72)),
            ),
            Gap(60),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  FlameAudio.bgm.stop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return GamePlay();
                    }),
                  );
                },
                child: Text(
                  'Play',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
