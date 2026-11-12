import 'package:flutter/material.dart';

Future<String?> showInputPopup(BuildContext context, String header, String prompt) async {
    final TextEditingController controller = TextEditingController();

    final String? input = await ShowDialog<String>(
        context: context,
        barrierDismissible: false,

        builder: (BuilderContext dialogContext) {
            return AlertDialog(
                title: Text(header),
                    
                content: TextField(
                    controller: controller,
                    autofocus: true,
                ),

                actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(null);
                        child: const Text('Cancel'),
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(controller.text);
                        child: const Text('Confirm'),
                    ),
                ],
            );
        }
    );

    controller.dispose;
    return input;
}