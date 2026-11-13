import 'package:flutter/material.dart';
import '../models/case.dart';
import '../models/event.dart';
import '../widgets/refresh_list.dart';

class CaseDetailsPage extends StatelessWidget {
    final Case linkedCase;
    final Future<void> Function() onRefresh;

    const CaseDetailsPage({super.key, required this.linkedCase, required this.onRefresh});

    @override
    Widget build(BuildContext context) {
        final events = linkedCase.events;

        final List<Widget> sections = [
            Padding(
                padding: EdgeInsets.all(16),
                child: Text('Case Events', style: TextStyle(fontSize: 18)),
            ),
            eventsBox(events),
        ];

        return Scaffold(
            appBar: AppBar(title: const Text('Case Details')),
            body: refreshList(onRefresh, sections),
        );
    }

    // sections

        //TODO: make a section that has both title and card

    Card eventsBox(events) {
        if (events.isEmpty) {
            return Card(child: ListTile(title: Text('No events')));
        } else {
            return Card(
                elevation: 1,
                child: ExpansionTile(
                    title: Text(events.first.text),
                    subtitle: Text(events.first.date),
                    children: [eventList(events)],
                ),
            );
        }
    }


    Widget eventList(List<Event> events) {
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            itemCount: events.length,

            itemBuilder: (context, index) {
                final Event event = events[index];

                return IntrinsicHeight(
                    child: Row(
                        children: [
                            SizedBox( //the timeline graphic with dots and lines
                                width: 24,
                                child: Column(
                                    children: [
                                        Expanded( child: Container(width: 2, color: Colors.grey)), //top line
                                        Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle), // circle
                                        ),
                                        Expanded(child: Container(width: 2, color: index == events.length - 1 ? Colors.transparent : Colors.grey)), // bottom line
                                    ],
                                ),
                            ),

                            Expanded(
                                child: ListTile(
                                    title: Text(event.text),
                                    subtitle: Text(event.date),
                                ),
                            ),
                        ],
                    ),
                );
            },
        );
    }
}
