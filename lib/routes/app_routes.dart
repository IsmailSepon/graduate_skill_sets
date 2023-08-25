
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth/login.dart';
import '../auth/registration.dart';
import '../dashboard/dashboard.dart';

class AppRoutes {

  /// The route configuration.
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Registration();//Dashboard();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
            },
          ),
          GoRoute(
            path: 'registration',
            builder: (BuildContext context, GoRouterState state) {
              return const Registration();
            },
          ),
          // GoRoute(
          //   path: 'dashboard',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const Registration();
          //   },
          // ),
        ],
      ),
    ],
  );
}
