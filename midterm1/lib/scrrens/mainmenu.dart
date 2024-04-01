import 'package:flutter/material.dart';
import 'package:midterm1/scrrens/gameplay.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg6.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Dodge Game',
                  
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.red
                  )
                  
                ),
              ),
              SizedBox(
                width: 400,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return GamePlay();
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Change button color as needed
                  ),
                  child: Text(
                    'Play',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
