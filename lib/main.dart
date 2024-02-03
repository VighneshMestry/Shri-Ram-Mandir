import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shri_ram_mandir/features/admin/screens/event_upload_screen.dart';
import 'package:shri_ram_mandir/features/home/screens/home_screen.dart';
import 'package:shri_ram_mandir/features/music/screens/bhajan_screen.dart';
import 'package:shri_ram_mandir/features/music/screens/music_player.dart';
import 'package:shri_ram_mandir/firebase_options.dart';
import 'package:shri_ram_mandir/widgets/bottom_bar.dart';

void main() async {
//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shri Ram Mandir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BottomBar(),
      getPages: [
        GetPage(name: "/", page: () => BottomBar()),
        GetPage(name: "/home", page: () => HomeScreen()),
        GetPage(name: "/music-player", page: () => MusicPlayer()),
        GetPage(name: "/bhajan", page: () => BhajanScreen()),
        GetPage(name: "/admin/event-upload", page: () => EventUploadScreen()),
      ],
    );
  }
}
