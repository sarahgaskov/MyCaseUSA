class Event {
	final String date;
	final String text;

	Event({required this.date, required this.text});

	//factory for making events from json
	factory Event.fromJson(Map<String, dynamic> json) => Event(
		date: json['date'] ?? '',
		text: json['completed_text_en'] ?? ''
	);
}
