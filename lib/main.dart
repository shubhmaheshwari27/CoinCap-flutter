import 'package:coincap/models/app_config.dart';
import 'package:coincap/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:get_it/get_it.dart';

import 'pages/home_page.dart';

Future<void> loadConfig() async {
    
  String _configContent = await rootBundle.loadString("assets/config/main.json");
  Map _configData = jsonDecode(_configContent);
  GetIt.instance.registerSingleton<AppConfig>(AppConfig(COIN_API_BASE_URL: _configData["COIN_API_BASE_URL"],),);
}

void registerHTTPService() {
  GetIt.instance.registerSingleton<HTTPService>(
    HTTPService(),
  );
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHTTPService();
  // await GetIt.instance.get<HTTPService>().get("/coins/bitcoin");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
