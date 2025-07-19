import 'package:contacts_manager_ui/routing/app_router.dart';
import 'package:contacts_manager_ui/utils/global_sharedpref.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalSharedpref.init();
  runApp(
    MyApp(
      router: AppRouter(),
    ),
  );
}
