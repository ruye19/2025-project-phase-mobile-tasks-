import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/pages/home_page.dart';
import '../../../features/auth/presentation/pages/login_page_new.dart' as login;
import '../../../features/auth/presentation/pages/register_page_new.dart' as register;
import '../../../features/auth/presentation/pages/splash_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const login.LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const register.RegisterPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('No route defined for ${state.uri}'),
    ),
  ),
);
