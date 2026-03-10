import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/core/networking/dio_helper.dart';
import 'core/networking/supabase_service.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/widgets/simple_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  DioHelper.init();
  Bloc.observer = SimpleObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tastee',
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: Routes.layoutBottomNavBar,
    );
  }
}
