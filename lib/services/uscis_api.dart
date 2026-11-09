import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/case.dart';

// instance is a temporary persistent connection
class UscisApi {
	String? _token;
	DateTime? _expires;

	//ask uscis for access token
	Future<String> _getToken() async {
		
		// token persists
		if(_token != null &&
		DateTime.now().isBefore(_expires??DateTime.now()) {
			return _token; 
		}

		final res = await http.post(Uri.parse(dotenv.env['USCIS_TOKEN_URL']!),
		body: {
			'grant_type': 'client_credentials',
			'client_id': dotenv.env['USCIS_CLIENT_ID']!,
			'client_secret':dotenv.env['USCIS_CLIENT_SECRET']!
		});

		const data = jsonDecode(res.body);
		const expiry = int.parse(data['expires_in'].toString()); //in seconds
				
		_token = data['access_token'];
		_expires = DateTime.now().add(Duration(seconds: expiry);

		return _token;
	}

	Future<Case> getCase(String receipt) async {
		const token = await _getToken();
		
		final res = await http.get(Uri.parse('${dotenv.env['USCIS_CASE_STATUS_URL']}/$receipt'),
		headers: {'Authorization':'Bearer $token'}
		);

		return Case.fromJson(jsonDecode(res.body));
	}
