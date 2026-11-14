import 'package:flutter/material.dart';
import '../models/case.dart';
import '../models/process_time.dart';
import '../services/api.dart';
import '../data/detailed_names.dart';

const Map<String, String> titles = {
    'nickname': 'Nickname',
    'category': 'Case Category',
    'office': 'Field Office',
};

class CaseEditPage extends StatefulWidget {
    final Case linkedCase;
    final Map<String, String> casePersonal;

    const CaseEditPage({super.key, required this.linkedCase, required this.casePersonal});

    @override
    State<CaseEditPage> createState() => CaseEditPageState();
}

class CaseEditPageState extends State<CaseEditPage> {
    late final linkedCase = widget.linkedCase;
    late final casePersonal = widget.casePersonal;

    Future<List<ProcessTime>> getTimes() => Api().getProcTimes(linkedCase.form);

    List<ProcessTime>? timeList; // null while loading
    // contains now just time info but also office and category info

    late String category = casePersonal['category']!; // office depends on category
    late String office = casePersonal['office']!;

    @override
    void initState() {
        super.initState();
        loadTimes();
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
            body: timeList == null ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(16.0),

                    child: Form(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children:[
                            for(final field in casePersonal.keys)
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

                            Builder(builder: (context) => ElevatedButton(
                                onPressed: () {
                                    Form.of(context).save();
                                    Navigator.of(context).pop();
                                },
                                child: const Text('Save'),
                            )),
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
                return dropdown('category', category, categories,
                    (value) => setState(() {
                        category = value ?? '';
                        office = ''; // new categiry resets office
                    })
                );
            case 'office':
                if (category.isEmpty) {
                    return Text('Pick a category first', style: TextStyle(color: Colors.grey));
                } else {
                    var offices = <String, String>{};
                    for(final time in timeList) {
                        if(time.category == category) {
                            offices[time.office] = officeNames[time.office] ?? time.office;
                        }
                    }

                    return dropdown('office', office, offices,
                        (value) => setState(() => office = value ?? '')
                    );
                }
            default:
                return TextFormField(
                    initialValue: casePersonal[field],
                    onSaved: (value) => casePersonal[field] = value!.trim(),
                );
        }
        
    }

    Widget dropdown(String field, String id, Map<String, String> items, ValueChanged<String?> onChanged) {
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
            onSaved: (value) => casePersonal[field] = value ?? '',
        );
    }
}
