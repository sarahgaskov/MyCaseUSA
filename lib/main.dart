import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/dashboard.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await dotenv.load(fileName: '.env');
	runApp(const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: DashboardPage()
	));
}
