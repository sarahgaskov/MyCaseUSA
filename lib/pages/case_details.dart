import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/case.dart';
import '../models/event.dart';
import '../widgets/refresh_list.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';


class CaseDetailsPage extends StatelessWidget {
    final Case linkedCase;
    final Map<String, String> casePersonal;
    final Future<void> Function() onRefresh;

    const CaseDetailsPage({super.key, required this.linkedCase, required this.casePersonal, required this.onRefresh});

    @override
    Widget build(BuildContext context) {
        final events = linkedCase.events;

        final List<Widget> sections = [
            formCard(linkedCase.receipt, linkedCase.form, casePersonal['nickname']!),
            ...statusSection(linkedCase.status, linkedCase.updated, linkedCase.description),
            ...eventSection(events)
        ];

        return Scaffold(
            appBar: AppBar(title: const Text('Case Details')),
            body: refreshList(onRefresh, sections),
        );
    }

    // sections

    Widget sectionTitle(String title, [String description = '']) { //TODO: Add description
        return Padding (
            padding: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 8.0, right: 8.0),
            child: Text(title, style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            )),
        );
    }



    // 1 - form section

    Card formCard(String receipt, String form, String nickname) {
        return Card(
            elevation: 1,
            child: ListTile(
                title: Row(children: [
                    Text(receipt + " ", style: TextStyle(
                        fontWeight: FontWeight.bold,
                    )),

                    Icon(Icons.copy, size: 16, color: Colors.grey)
                ]),

                subtitle: Text(nickname.isEmpty ? form : '$form ($nickname)'),
                onTap: () async {await Clipboard.setData(ClipboardData(text: receipt));}
            ),
        );
    }
 
    // 2 - status section
 
    List<Widget> statusSection(status, updated, description) {
        return [
            sectionTitle('Status'),
            statusCard(status, updated, description),
        ];
    }
 
    Card statusCard(String status, String updated, String description) {
        return Card(
            elevation: 1,
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        if (updated.isNotEmpty)
                            Text('Case updated: $updated', style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                            )),
 
                        SizedBox(height: 4),
 
                        Text(status.isEmpty ? 'No status' : status, style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                        )),
 
                        if (description.isNotEmpty) ...[
                            SizedBox(height: 8),
                            HtmlWidget(
                                description,
                                onTapUrl: (url) => launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.externalApplication,
                                ),
                            ),
                        ],
                    ],
                ),
            ),
        );
    }
 
    // 3 - event section
 
    List<Widget> eventSection(events) {
        return [
            sectionTitle('Case Events'),
            eventsCard(events),
        ];
    }

    Card eventsCard(events) {
        if (events.isEmpty) {
            return Card(child: ListTile(title: Text('No events')));
        } else {
            return Card(
                elevation: 1,
                child: ExpansionTile(
                    title: Text(events.first.text),
                    subtitle: Text(events.first.date),
                    children: [eventList(events.skip(1).toList())],
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
 