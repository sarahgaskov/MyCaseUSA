import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api.dart';
import '../models/case.dart';
import '../models/event.dart';
import '../widgets/popups.dart';
import '../widgets/refresh_list.dart';
import 'case_details.dart';
import 'case_edit.dart';
import 'settings.dart';

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
			description: 'On November 10, 2026, we received your Form I-130, Petition for Alien Relative, Receipt Number TEST0000000001, and sent you the receipt notice that describes how we will process your case. Please follow the instructions in the notice. If you have any questions, contact the USCIS Contact Center. If you move, go to <a href="https://www.uscis.gov/addresschange" target="_blank">www.uscis.gov/addresschange</a> to give us your new mailing address.',
			updated: '11-10-2026 09:15:32',
			events: [
				Event(date: '2026-11-10', text: 'Case Was Received'),
				Event(date: '2026-11-05', text: 'Fees Were Paid'),
				Event(date: '2026-11-01', text: 'Case Was Filed'),
			],
		),
	};

    //todo remove temporary test
    final Map<String, Map<String, String>> casePersonal = {
        'TEST0000000001': newCasePersonal(),
    };

    // every case gets all personal fields
    static Map<String, String> newCasePersonal() => {
        'nickname': '',
        'category': '',
        'office': '',
    };

    //TODO: add "String receipt" arg
    Future<void> addCase(String receipt) async {
        final prefs = await SharedPreferences.getInstance();
        final receipts = prefs.getStringList('receipts') ?? [];

        //TODO: check if even valid case/receipt -- in api.dart
        if (!receipts.contains(receipt)) {
            final newReceipts = [...receipts, receipt];
            await prefs.setStringList('receipts', newReceipts);
        }

        await refresh(); //so that the new cases are pulled
    }

    @override
    void initState() {
        super.initState();
        loadCases();
    }

    Future<void> loadCases() async {
        await loadPersonal();
        await refresh();
    }

    Future<void> loadPersonal() async {
        final prefs = await SharedPreferences.getInstance();
        final personal = jsonDecode(prefs.getString('personal') ?? '{}');

        for (final attribute in personal.entries) {
            casePersonal[attribute.key] = Map<String, String>.from(attribute.value);
        }
    }

    Future<void> clearData() async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('receipts');
        await prefs.remove('personal');

        setState(() {
            cases.clear();
            casePersonal.clear();
        });
    }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
                title: const Text('MyCaseUSA'),
                actions: [
                    IconButton(
                        icon: _refreshing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                            ) : const Icon(Icons.refresh),

                        onPressed: _refreshing ? null : refresh,
                    ),
                    IconButton(
                        icon: const Icon(Icons.settings),
                        tooltip: 'Settings',
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SettingsPage(
                                onClear: clearData,
                            )),
                        ),
                    ),
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
        final prefs = await SharedPreferences.getInstance();
        final receipts = prefs.getStringList('receipts') ?? [];

        if (_refreshing || receipts.isEmpty) { return; }

        setState(() { _refreshing = true; });

        final updated = <String, Case>{};
        //TODO: add failed too

        for (var receipt in receipts) {
            try {
                updated[receipt] = await api.getCase(receipt);
            } catch(e) {
                //TODO: handle later
            }
        }

        setState(() {
            _refreshing = false;
            cases.addAll(updated);
            for (var receipt in updated.keys) {
                casePersonal[receipt] ??= newCasePersonal();
            }
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
        final nickname = casePersonal[linkedCase.receipt]!['nickname']!;

        return Card(
            elevation: 1,
            child: ListTile(
                title: Text(nickname.isEmpty ? linkedCase.form : nickname),
                subtitle: Text(linkedCase.status),
                trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit case',
                    onPressed: () async {
                        await Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CaseEditPage(linkedCase: linkedCase)),
                        );
                        await loadPersonal();
                        setState(() {});
                    },
                ),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CaseDetailsPage(linkedCase: linkedCase, casePersonal: casePersonal[linkedCase.receipt]!, onRefresh: refresh)),
                ),
            ),
        );
    }
}


