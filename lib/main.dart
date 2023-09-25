// Import necessary packages and files
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/controllers/auth_controller.dart';
import 'package:tiktok/firebase_options.dart';
import 'package:tiktok/views/screens/auth/login_screen.dart';

// Main function, the entry point of the Flutter application
void main() async {
  // Ensure Flutter is initialized and ready to run
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the provided options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    // Initialize the AuthController for state management
    Get.put(AuthController());
  });

  // Run the Flutter application by calling runApp
  runApp(const MyApp());
}

// MyApp class, a StatelessWidget representing the root of the application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Disable the debug banner in the top right corner
      debugShowCheckedModeBanner: false,
      
      // Set the title of the application
      title: 'Tik Tok',
      
      // Define the theme for the entire application
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      
      // Set the initial screen of the application to the LoginScreen widget
      home: LoginScreen(),
    );
  }
}
