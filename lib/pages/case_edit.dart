import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/case.dart';
import '../models/process_time.dart';
import '../services/api.dart';
import '../data/detailed_names.dart';
import 'dashboard.dart';

const Map<String, String> titles = {
    'nickname': 'Nickname',
    'category': 'Case Category',
    'office': 'Field Office',
};

class CaseEditPage extends StatefulWidget {
    final Case linkedCase;

    const CaseEditPage({super.key, required this.linkedCase});

    @override
    State<CaseEditPage> createState() => CaseEditPageState();
}

class CaseEditPageState extends State<CaseEditPage> {
    late final linkedCase = widget.linkedCase;
    Map<String, String>? tempPersonal;

    Future<List<ProcessTime>> getTimes() => Api().getProcTimes(linkedCase.form);

    List<ProcessTime>? timeList; // null while loading
    // contains now just time info but also office and category info

    @override
    void initState() {
        super.initState();
        
        loadTimes();
        loadPersonal();
    }

    Future<void> loadPersonal() async {
        final prefs = await SharedPreferences.getInstance();

        final personal = jsonDecode(prefs.getString('personal') ?? '{}');
        final casePersonal = personal[linkedCase.receipt] ?? {};

        setState(() {
            final newPersonal = DashboardPageState.newCasePersonal();
            newPersonal.addAll(casePersonal);
            tempPersonal = newPersonal;
        });
    }

    Future<void> savePersonal() async {
        final prefs = await SharedPreferences.getInstance();
        final personal = jsonDecode(prefs.getString('personal') ?? '{}');

        personal[linkedCase.receipt] = tempPersonal;
        await prefs.setString('personal', jsonEncode(personal));
    }

    Future<void> loadTimes() async {
        List<ProcessTime> list = await getTimes();

        setState(() {
            timeList = list;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Edit Case')),
            body: timeList == null || tempPersonal == null ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(16.0),

                    child: Form(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children:[
                            for(final field in tempPersonal!.keys)
                                Padding(
                                    padding: EdgeInsets.only(bottom: 16.0),

                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(titles[field] ?? field, style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                            )),

                                            fieldInput(field, timeList!),
                                        ],
                                    ),
                                ),

                            ElevatedButton(
                                onPressed: () async {
                                    await savePersonal();
                                    Navigator.of(context).pop();
                                },
                                child: const Text('Save'),
                            ),
                        ],
                    )),
                ),
        );
    }

    // input for each personal field
    Widget fieldInput(String field, List<ProcessTime> timeList) {

        switch(field) {
            case 'category':
                var categories = <String, String>{};
                for(final time in timeList) {
                    categories[time.category] = categoryNames[time.category] ?? time.category;
                }
                return dropdown('category', categories,
                    (value) => setState(() {
                        tempPersonal!['category'] = value ?? '';
                        tempPersonal!['office'] = ''; // new categiry resets office
                    })
                );
            case 'office':
                final category = tempPersonal!['category']!;

                if (category.isEmpty) {
                    return Text('Pick a category first', style: TextStyle(color: Colors.grey));
                } else {
                    var offices = <String, String>{};
                    for(final time in timeList) {
                        if(time.category == category) {
                            offices[time.office] = officeNames[time.office] ?? time.office;
                        }
                    }

                    return dropdown('office', offices,
                        (value) => setState(() => tempPersonal!['office'] = value ?? '')
                    );
                }
            default:
                return TextFormField(
                    initialValue: tempPersonal![field],
                    onChanged: (value) => tempPersonal![field] = value.trim(),
                );
        }
        
    }

    Widget dropdown(String field, Map<String, String> items, ValueChanged<String?> onChanged) {
        final id = tempPersonal![field]!;

        if (items.isEmpty) {
            return Text('No data for this form', style: TextStyle(color: Colors.grey));
        }

        var dropItems = <DropdownMenuItem<String>>[];
        for(final item in items.entries) {
            dropItems.add(DropdownMenuItem(value: item.key, child: Text(item.value)),);
        }

        return DropdownButtonFormField<String>(
            initialValue: items.containsKey(id) ? id : null,
            
            isExpanded: true,

            items: dropItems,

            onChanged: onChanged,
        );
    }
}
