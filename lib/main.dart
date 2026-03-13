import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/core/local/app_database.dart';
import 'package:tastee/core/networking/dio_helper.dart';
import 'package:tastee/core/theme/app_theme.dart';
import 'package:tastee/core/theme/theme_cubit.dart';
import 'package:tastee/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'core/networking/supabase_service.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/widgets/simple_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  DioHelper.init();
  Bloc.observer = SimpleObserver();

  final database = AppDatabase();
  final mealsDao = database.mealsDao;
  final favouriteCubit = FavouriteCubit(mealsDao)..loadFavourites();

  runApp(MyApp(favouriteCubit: favouriteCubit));
}

class MyApp extends StatelessWidget {
  final FavouriteCubit favouriteCubit;

  const MyApp({super.key, required this.favouriteCubit});

  @override
  Widget build(BuildContext context) {
    final hasSession = SupabaseService.client.auth.currentSession != null;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: favouriteCubit),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tastee',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            onGenerateRoute:
                AppRouter(favouriteCubit: favouriteCubit).generateRoute,
            initialRoute:
                hasSession ? Routes.layoutBottomNavBar : Routes.login,
          );
        },
      ),
    );
  }
}
