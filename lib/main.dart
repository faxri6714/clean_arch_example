import 'package:clean_arch_example/application.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'locator.dart';

void main() async{
  await Hive.initFlutter();
  setup();

  runApp(const Application());
}
