import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_observer.dart';
import 'core/di/injection_container.dart';
import 'core/presentation/routes/app_router.dart';
import 'core/presentation/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth/auth_event.dart';
import 'features/product/presentation/bloc/product/product_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up Bloc observer
  Bloc.observer = SimpleBlocObserver();

  // Initialize dependencies
  await init();

  // Check if user is logged in
  final sharedPreferences = await SharedPreferences.getInstance();
  final isLoggedIn = sharedPreferences.getString('auth_token') != null;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(AuthCheckRequested()),
        ),
        BlocProvider<ProductsBloc>(
          create: (context) => sl<ProductsBloc>()..add(ProductsLoadRequested()),
        ),
      ],
      child: MaterialApp.router(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: router,
      ),
    );
  }
}
