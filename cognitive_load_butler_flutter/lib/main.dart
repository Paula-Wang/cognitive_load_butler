import 'package:cognitive_load_butler_client/cognitive_load_butler_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:universal_html/html.dart' as html; // Add this import

import 'butler_demo_screen.dart';

late final Client client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request permission for Web Notifications
  if (html.Notification.permission == 'default') {
    await html.Notification.requestPermission();
  }

  const serverUrl = 'https://cognitive-load-butler-v2.api.serverpod.space/';

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initialize();

  runApp(const MyApp());
}
// ... rest of your MyApp class

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cognitive Load Butler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ButlerDemoScreen(), // 👈 DIRECTLY load your screen
      debugShowCheckedModeBanner: false,
    );
  }
}

