import 'package:cloud_storage_app/utils/router.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   static const appTitle = 'MyDrive';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appTitle,
      routerConfig: router,
       debugShowCheckedModeBanner: false,
     
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
    );
  }
}

