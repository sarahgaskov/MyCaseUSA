class ProcessTime {
    final String office;
    final String category;

    final double lowerMonths;
    final double upperMonths;
    
    final String fileDate;

    const ProcessTime({
		required this.office,
		required this.category,
		required this.lowerMonths,
		required this.upperMonths,
		required this.fileDate,
	});

    //make processing time from json
	factory ProcessTime.fromJson(Map<String, dynamic> json) {
        final newTime = json['offices'];

		return ProcessTime(
			office: newTime['office_code'] ?? '',
			category: newTime['subtype'] ?? '',
			lowerMonths: newTime['lower_months'] as double ?? 0.0,
			upperMonths: newTime['upper_months'] as double ?? 0.0,
			fileDate: newTime['service_request_date'] ?? '',
		);
	}
}