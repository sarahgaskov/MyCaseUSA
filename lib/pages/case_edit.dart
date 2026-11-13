import 'package:flutter/material.dart';
import '../models/case.dart';

const Map<String, String> titles = {
    'nickname': 'Nickname',
};

class CaseEditPage extends StatelessWidget {
    final Case linkedCase;
    final Map<String, String> casePersonal;

    const CaseEditPage({super.key, required this.linkedCase, required this.casePersonal});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Edit Case')),
            body: Padding(
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

                                        TextFormField(
                                            initialValue: casePersonal[field],
                                            onSaved: (value) => casePersonal[field] = value!.trim(),
                                        ),
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
}
