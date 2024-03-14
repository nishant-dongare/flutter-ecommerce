import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Auth {
  final url = 'https://fakestoreapi.com';
  final headers = {'Content-Type': 'application/json'};


  void login() async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https('https://fakestoreapi.com/auth/login', ''),
          body: {'username': 'doodle', 'password': 'blue'});
      print(response.body);
    } on Exception catch (_, e) {
      log(e.toString());
    }
  }

  FutureOr<void> register() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> products = jsonDecode(response.body);
      print(products);
    } else {
      print('Failed to load products. Error: ${response.statusCode}');
    }
  }

  FutureOr<void> postUser({required String username,required String password}) async {
    var url = Uri.parse('https://fakestoreapi.com/users');
    var body = jsonEncode({
      'email': username,
      'username': username,
      'password': password,
      'name': {'firstname': 'John', 'lastname': 'Doe'},
      'address': {
        'city': 'kilcoole',
        'street': '7835 new road',
        'number': 3,
        'zipcode': '12926-3874',
        'geolocation': {'lat': '-37.3159', 'long': '81.1496'}
      },
      'phone': '1-570-236-7033'
    });


    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print("User Added ${response.body}");
    } else {
      print('Failed to post user. Error: ${response.statusCode}');
    }
  }
}
