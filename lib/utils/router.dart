import 'package:cloud_storage_app/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
      // routes: <RouteBase>[
      //   GoRoute(
      //     path: 'detail',
      //     builder:  (BuildContext context, GoRouterState state) {
      //       return const Detilpage();
      //     }
      //     )
      // ]
      )
  ]
  
  );