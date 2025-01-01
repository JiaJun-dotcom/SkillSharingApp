// file for defining functions that link pages together for app functionality
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "http://127.0.0.1:8000"; //from your django backend api calls

Future<void> saveUserToken(token) async {
  final prefs = await SharedPreferences.getInstance();
//getting a instance of the shared preferences class to save the token returned by JWT in django backend
  await prefs.setString('user_token', token);
}

Future<String?> getUserToken() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('user_token');
//get this token using getString method, passing in the user_token as key.
}

Future<Profile> fetchProfile(String token) async {
  final response = await http.get(
    Uri.parse('$baseUrl/profiles'),
    headers: {'Authorization': 'Bearer $token'}, //uses JWT tokens to identify which profile u are referring to by extracting info from the token payload
  );
  if (response.statusCode == 200) {
    return Profile.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to retrieve Profile details');
  }
}

Future<List?> fetchSkill(String token, String query) async {
  String? token = await getUserToken();
  if (token == null) {
    throw Exception(
        'User token not found, please login first to retrieve data.');
  }

  final response = await http.get(
    Uri.parse('$baseUrl/skills/?query=$query'),
    headers: {'Authorization': 'Bearer $token'},
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    List<Skills> skillslist = data.map((skill) => Skills.fromJson(skill)).toList();
    return skillslist;
  } else {
    throw Exception('Failed to retrieve Skills details');
  }
}

Future<void> loginUser(String username, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/auth/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Assuming the response contains a token
    var data = jsonDecode(response.body);
    String token = data['key'];
    saveUserToken(token); // Save the token locally
  } else {
    throw Exception('Failed to log in');
  }
}

