import 'package:flutter/material.dart';
import 'package:tafeel_task/core/app.dart';
import 'package:tafeel_task/core/di/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MyApp());
}
