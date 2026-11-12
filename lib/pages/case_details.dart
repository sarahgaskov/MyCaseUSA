import 'package:flutter/material.dart';

class CaseDetailsPage extends StatelessWidget {
    final List<Widget> sections;

    const CaseDetailsPage({super.key, this.sections = const []});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Case Details')),
            body: ListView(children: sections),
        );
    }
}
