import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/case.dart';
import '../models/process_time.dart';

// instance is a temporary persistent connection
class Api {
	String? _token;
	DateTime? _expires;

	//ask uscis for access token
	Future<String> _getToken() async {
		
		// token persists
		if(_token != null &&
		DateTime.now().isBefore(_expires??DateTime.now())) {
			return _token!; 
		}

		final res = await http.post(Uri.parse(dotenv.env['USCIS_TOKEN_URL']!),
		body: {
			'grant_type': 'client_credentials',
			'client_id': dotenv.env['USCIS_CLIENT_ID']!,
			'client_secret':dotenv.env['USCIS_CLIENT_SECRET']!
		});

		final data = jsonDecode(res.body);
		final expiry = int.parse(data['expires_in'].toString()); //in seconds
				
		_token = data['access_token'];
		_expires = DateTime.now().add(Duration(seconds: expiry));

		return _token!;
	}

	Future<Case> getCase(String receipt) async {
		final token = await _getToken();
		
		final res = await http.get(Uri.parse('${dotenv.env['USCIS_CASE_STATUS_URL']}/$receipt'),
		headers: {'Authorization':'Bearer $token'});

		return Case.fromJson(jsonDecode(res.body));
	}

	Future<List<ProcessTime>> getProcTimes(String form) async{
		final res = await http.get(Uri.parse('https://immigrationtimes.org/api/v1/${form.toLowerCase()}.json'));
		final data = jsonDecode(res.body);

		if(data['status'] == 'ok') {

			return(data['offices'] as List? ?? [])
				.map((e) => ProcessTime.fromJson(e)).toList();

		} else {
			return [];
		}
	}
}