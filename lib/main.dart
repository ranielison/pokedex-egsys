import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_egsys/core/di/injection_container.dart' as di;
import 'package:pokedex_egsys/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const App());
}
