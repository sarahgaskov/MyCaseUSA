import 'package:flutter/material.dart';
import '../services/api.dart';

class TestPage extends StatefulWidget {
	const TestPage({super.key});

	@override
	State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage>{
	final api = Api();
	String info = 'Waiting to fetch';
	
	//test fetch
	Future<void> fetch() async {
		final newCase = await api.getCase('EAC9999103403');

		setState(() {
			info = '${newCase.form}: ${newCase.status}';
		});
	}
	

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('TestPage')),
			
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,

					children: [
						Text(info),
						FloatingActionButton(
							onPressed: fetch,
							child: const Icon(Icons.search),
						),
					],
				),
			),
		);
	}
}
