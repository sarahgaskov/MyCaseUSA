import 'event.dart';

// case snapshot
class Case {
	final String receipt;
	final String form;
	final String status;
	final String description;
	final String updated;

	final List<Event> events;

	const Case({
		required this.receipt,
		required this.form,
		required this.status,
		required this.description,
		this.updated = '',
		required this.events,
	});

	
	//make case from json
	factory Case.fromJson(Map<String, dynamic> json) {
		final newCase = json['case_status'];
		
		return Case(
			receipt: newCase['receiptNumber'] ?? '',
			form: newCase['formType'] ?? '',
			status: newCase['current_case_status_text_en'] ?? '',
			description: newCase['current_case_status_desc_en'] ?? '',
			updated: newCase['modifiedDate'] ?? '',

			events: (newCase['hist_case_status'] as List? ?? [])
				.map((e) => Event.fromJson(e))
				.toList()		
		);
	}
}
