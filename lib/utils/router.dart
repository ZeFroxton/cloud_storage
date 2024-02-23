import 'package:cloud_storage_app/screen/home.dart';
import 'package:cloud_storage_app/screen/loginpage.dart';
import 'package:cloud_storage_app/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder:  (BuildContext context, GoRouterState state) {
            return const Home();
          }
          ),
          GoRoute(
          path: 'setting',
          builder:  (BuildContext context, GoRouterState state) {
            return const SettingsPage1();
          }
          )
      ]
      )
  ]
  
  );