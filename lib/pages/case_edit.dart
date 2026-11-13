import 'package:flutter/material.dart';
import '../models/case.dart';

class CaseEditPage extends StatelessWidget {
    final Case linkedCase;

    const CaseEditPage({super.key, required this.linkedCase});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Edit Case')),
            body: const Center(
                //TODO: nickname and office fields
            ),
        );
    }
}
