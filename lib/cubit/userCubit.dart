import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:test/models/product.dart';


class UserData{
  String? token;
  User? user;
  List<Product>? productList;
  List<Product>? cart;
  UserData({this.token,this.user,this.productList,this.cart});
}


class UserCubit extends Cubit<UserData>{
  final headers = {'Content-Type': 'application/json'};

  UserCubit():super(UserData());

  FutureOr<void> register({required String username,required String password}) async {
    final url = Uri.parse('https://fakestoreapi.com/users');
    dynamic body = jsonEncode({
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
      final json = jsonDecode(response.body);
      if(json['id'] != 0){
        //print(json['id']);
        body = jsonDecode(body);
        body['id'] = json['id'];
        //print(body['id']);
        emit(UserData(user:User.fromJson(body)));
      }
    } else {
      print('Failed to post user. Error: ${response.statusCode}');
    }    
  }


  FutureOr<void> login({required String username,required String password}) async {
    final loginUrl = Uri.parse('https://fakestoreapi.com/auth/login');
    dynamic body = jsonEncode({
      'username': username,
      'password': password,
    });

    var response = await http.post(loginUrl, headers: headers, body: body);

    if (response.statusCode == 200) {
      print("User Login ${response.body}");
      final json = jsonDecode(response.body);
      emit(UserData(token: json['token']));

    } else {
      print('Failed to post user. Error: ${response.body}');
    }
  }

  FutureOr<void> getProducts() async {
    final response =
    await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<Product> productList=[];
      final List products = jsonDecode(response.body);
      //print(products);
      for(var product in products){
        productList.add(Product.fromJson(product));
      }
      emit(UserData(productList: productList));
      //print(state.productList);
    } else {
      print('Failed to load products. Error: ${response.statusCode}');
    }
  }

  void addToCart(Product product){
    if(state.cart == null){
      final emptyList = <Product>[];
      emit(UserData(cart:emptyList));
    }
    List<Product> pl = state.cart!;
    pl.add(product);
    emit(UserData(cart: pl));
  }

  bool isProductInCart(Product product) {
    // Check if cart is null
    if (state.cart == null) {
      return false;
    }

    // Iterate through each product in the cart
    for (Product cartProduct in state.cart!) {
      // Check if the product ID matches the given product
      if (cartProduct.id == product.id) {
        return true; // Product is already in the cart
      }
    }
    return false; // Product is not in the cart
  }

  void removeFromCart(Product product) {
    if (state.cart == null) {
      return; // Cart is empty, nothing to remove
    }

    List<Product> updatedCart = List<Product>.from(state.cart!);

    updatedCart.removeWhere((cartProduct) => cartProduct.id == product.id);

    emit(UserData(cart: updatedCart));
  }
}