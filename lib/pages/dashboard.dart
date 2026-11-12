import 'package:flutter/material.dart';
import '../services/api.dart';
import '../models/case.dart';

class DashboardPage extends StatefulWidget {
	const DashboardPage({super.key});

	@override
	State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>{
	final api = Api();
	final Map<String, Case> cases = {};

    //TODO: add "String receipt" arg
    Future<void> addCase() async {
        //final newCase = await api.getCase(receipt);
        final newCase = await api.getCase('EAC9999103403');

        //TODO: check if even valid case/receipt -- in api.dart
        // fail if no case imported
		setState(() {
			cases[newCase.receipt] = newCase;
		});
    }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
                title: const Text('MyCaseUSA'),
                actions: [
                    IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () => _refreshKey.currentState?.show(),
                    )
                ]
            ),
			
			body: caseListView(cases),

			floatingActionButton: FloatingActionButton.extended(
                onPressed: addCase,
                icon: const Icon(Icons.add),
                label: const Text('Add case'),
            ),
		);
	}
    
    // refreshing

    final _refreshKey = GlobalKey<RefreshIndicatorState>();
    bool _refreshing = false;

    Future<void> refresh() async{
        if (_refreshing || cases.isEmpty) { return; }
        _refreshing = true;

        final updated = <String, Case>{};
        //TODO: add failed too

        for (var receipt in updated.keys.toList()) {
            try {
                updated[receipt] = await api.getCase(receipt);
            } catch(e) {
                //TODO: handle later
            }

            _refreshing = false;

            setState(() {
                cases.addAll(updated);
            });
        }
    }

    // Widgets

    // draw caseListView
    Widget caseListView(Map<String, Case> setCases) {
        final List<dynamic> cases = setCases.values.toList() ?? [];

        return RefreshIndicator(
            key: _refreshKey,
            onRefresh: refresh,
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),

                itemCount: cases.length,
                itemBuilder: (context, index) {
                    final Case entry = cases[index];

                    caseCard(entry);
                }
            )
        );
    }


    Card caseCard(Case linkedCase) {
        return Card(
            elevation: 1,
            child: ListTile(
                title: Text(linkedCase.form),
                subtitle: Text(linkedCase.status),
            ),
        );
    }
}


