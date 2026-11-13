import 'package:flutter/material.dart';
import '../services/api.dart';
import '../models/case.dart';
import '../models/event.dart';
import '../widgets/popups.dart';
import '../widgets/refresh_list.dart';
import 'case_details.dart';

class DashboardPage extends StatefulWidget {
	const DashboardPage({super.key});

	@override
	State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>{
	final api = Api();

    //todo remove temporary test
	final Map<String, Case> cases = {
		'TEST0000000001': Case(
			receipt: 'TEST0000000001',
			form: 'I-130',
			status: 'Case Was Received',
			description: '',
			events: [
				Event(date: '2026-11-10', text: 'Case Was Received'),
				Event(date: '2026-11-05', text: 'Fees Were Paid'),
				Event(date: '2026-11-01', text: 'Case Was Filed'),
			],
		),
	};

    //TODO: add "String receipt" arg
    Future<void> addCase(String receipt) async {
        final newCase = await api.getCase(receipt);
        //final newCase = await api.getCase('EAC9999103403');

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
                        onPressed: _refreshing ? null : refresh,
                    )
                ]
            ),
			
			body: caseListView(cases),

			floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                    final receipt = await showInputPopup(context,
                        "Add case",
                        "Receipt number"
                    );

                    if(receipt != null) {
                        addCase(
                            receipt.trim().toUpperCase()
                        );
                    }
                    
                    return;
                },
                icon: const Icon(Icons.add),
                label: const Text('Add case'),
            ),
		);
	}
    
    // refreshing

    bool _refreshing = false;

    Future<void> refresh() async{
        if (_refreshing || cases.isEmpty) { return; }
        _refreshing = true;

        final updated = <String, Case>{};
        //TODO: add failed too

        for (var receipt in cases.keys.toList()) {
            try {
                updated[receipt] = await api.getCase(receipt);
            } catch(e) {
                //TODO: handle later
            }
        }

        setState(() {
            _refreshing = false;
            cases.addAll(updated);
        });
    }



    // Widgets

    // draw caseListView
    Widget caseListView(Map<String, Case> setCases) {
        final List<dynamic> cases = setCases.values.toList() ?? [];

        // if list is empty then dont show case, theres nothing to show

        if(cases.isEmpty){
            return Center(
                child: Text('No cases added',
                    style: TextStyle(
                        color: Colors.grey,
                    ),
                ),
                
            );
        } else {
            return refreshList(refresh, setCases.values.map(caseCard).toList());
        }

        
    }


    Card caseCard(Case linkedCase) {
        return Card(
            elevation: 1,
            child: ListTile(
                title: Text(linkedCase.form),
                subtitle: Text(linkedCase.status),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CaseDetailsPage(linkedCase: linkedCase, onRefresh: refresh)),
                ),
            ),
        );
    }
}


