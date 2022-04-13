import 'package:app_catalogo/app.dart';
import 'package:core_catalogo_module/core/app_component.dart'
    as core_component_catalogue;
import 'package:app_catalogo/core/app_component.dart' as app_catalogue_entry;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await core_component_catalogue.init();
  await app_catalogue_entry.init();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_) => const MyApp(),
    ),
  );
}
