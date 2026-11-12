import 'package:flutter/material.dart';

Future<String?> showInputPopup(BuildContext context, String header, String prompt) async {
    final TextEditingController controller = TextEditingController();

    final String? input = await showDialog<String>(
        context: context,
        barrierDismissible: false,

        builder: (BuildContext dialogContext) {
            return AlertDialog(
                title: Text(header),
                    
                content: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                        hintText: prompt,
                    ),
                ),

                actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(null),
                        child: const Text('Cancel'),
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(controller.text),
                        child: const Text('Confirm'),
                    ),
                ],
            );
        }
    );

    controller.dispose();
    return input;
}