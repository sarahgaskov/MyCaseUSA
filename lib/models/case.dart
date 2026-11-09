import 'event.dart';

// case snapshot
class Case {
	final String receipt;
	final String form;
	final String status;
	final String description;
	
	final List<Event> events;

	const Case({
		required this.receipt,
		required this.form,
		required this.status,
		required this.description,
		required this.history,
	});

	
	//make case from json
	factory Case.fromJson(Map<String, String> json) {
		final case = json['case_status'];
		
		return Case(
			receipt: case['receiptNumber'],
			form: case['formType'],
			status: case['current_case_status_text_en'],
			description: case['current_case_status_desc_en'],
			
			events: (case['hist_case_status'] as List? ?? [])
				.map((e) => Event.fromJson(e))
				.toList()		
		);
	}
}
