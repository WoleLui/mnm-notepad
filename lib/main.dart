import 'package:flutter/material.dart';
import 'package:mnm_notepad/message_database.dart';
import 'package:mnm_notepad/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'message_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de la base de données
    MessageDatabase.instance.database;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) { MessageProvider().loadMessages();  }, // Charger les messages au démarrage
      child: MaterialApp(
        title: 'MNM NotePad',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}