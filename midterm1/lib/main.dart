import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midterm1/scrrens/mainmenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MidtermProj());
}

class MidtermProj extends StatelessWidget {
  const MidtermProj({Key? key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenu(),
      theme: ThemeData(
       
        textTheme: GoogleFonts.creepsterTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
