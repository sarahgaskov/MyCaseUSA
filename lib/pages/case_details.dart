import 'package:flutter/material.dart';
import '../widgets/refresh_list.dart';
 
class CaseDetailsPage extends StatelessWidget {
    final Future<void> Function() onRefresh;
    final List<Widget> sections;
 
    const CaseDetailsPage({super.key, required this.onRefresh, this.sections = const []});
 
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Case Details')),
            body: refreshList(onRefresh, sections),
        );
    }
}