import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
    final VoidCallback onClear;

    const SettingsPage({super.key, required this.onClear});

    @override
    State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
    SharedPreferences? prefs;

    @override
    void initState() {
        super.initState();
        loadSettings();
    }

    Future<void> loadSettings() async {
        final loaded = await SharedPreferences.getInstance();

        setState(() {
            prefs = loaded;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Settings')),

            body: prefs == null ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(16.0),

                    child: Form(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children:[
                            DropdownButtonFormField<bool>(
                                initialValue: prefs!.getBool('reminders') ?? true,

                                items: const [
                                    DropdownMenuItem(value: true, child: Text('Enable reminders')),
                                    DropdownMenuItem(value: false, child: Text('Disable reminders')),
                                ],

                                onChanged: (value) => prefs!.setBool('reminders', value!),
                            ),

                            ElevatedButton(
                                onPressed: () {
                                    widget.onClear();
                                    Navigator.of(context).pop();
                                },
                                child: const Text('Clear data'),
                            ),
                        ],
                    )),
                ),
        );
    }
}
