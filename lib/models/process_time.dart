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
        
		return ProcessTime(
			office: json['office_code'] ?? '',
			category: json['subtype'] ?? '',
			lowerMonths: (json['lower_months'] as num? ?? 0).toDouble(),
			upperMonths: (json['upper_months'] as num? ?? 0).toDouble(),
			fileDate: json['service_request_date'] ?? '',
		);
	}
}