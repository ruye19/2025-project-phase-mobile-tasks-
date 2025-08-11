import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/product/domain/entities/product.dart';
import '../../../features/product/presentation/pages/pages.dart';
import '../../../features/auth/presentation/pages/pages.dart' as auth_pages;
import 'app_routes.dart';
import '../../../injection_container.dart' as di;

final router = GoRouter(
  redirect: (context, state) {
    final SharedPreferences prefs = di.serviceLocator<SharedPreferences>();
    final token = prefs.getString('AUTH_TOKEN');
    final bool isLoggedIn = token != null && token.isNotEmpty;

    final String loc = state.matchedLocation;
    final bool isAuthRoute =
        loc == Routes.splash || loc == Routes.signIn || loc == Routes.signUp;

    if (!isLoggedIn && !isAuthRoute) {
      return Routes.signIn;
    }
    if (isLoggedIn && (loc == Routes.signIn || loc == Routes.signUp)) {
      return Routes.home;
    }
    return null;
  },
  routes: <RouteBase>[
    // Splash
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const auth_pages.SplashPage(),
    ),

    // Auth
    GoRoute(
      path: Routes.signIn,
      builder: (context, state) => const auth_pages.SignInPage(),
    ),
    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => const auth_pages.SignUpPage(),
    ),

    // Home
    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomePage(),
    ),

    // Product
    GoRoute(
      path: Routes.productDetail,
      builder: (context, state) {
        final product = state.extra as Product;
        return ProductDetailPage(product: product);
      },
    ),

    GoRoute(
      path: Routes.addProduct,
      builder: (context, state) => const AddProductPage(),
    ),

    GoRoute(
      path: Routes.updateProduct,
      builder: (context, state) {
        final product = state.extra as Product;
        return UpdateProductPage(product: product);
      },
    ),
  ],
);
