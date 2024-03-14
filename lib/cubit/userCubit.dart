import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:test/models/product.dart';

class UserData {
  String? token;
  User? user;
  List<Product>? productList;
  List<Product>? cart;
  UserData({this.token, this.user, this.productList, this.cart});

  UserData copyWith({
    String? token,
    User? user,
    List<Product>? productList,
    List<Product>? cart,
  }) {
    return UserData(
      token: token ?? this.token,
      user: user ?? this.user,
      productList: productList ?? this.productList,
      cart: cart ?? this.cart,
    );
  }
}

class UserCubit extends Cubit<UserData> {
  final headers = {'Content-Type': 'application/json'};

  UserCubit() : super(UserData());

  FutureOr<String> register(
      {required String username, required String password}) async {
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
      if (json['id'] != 0) {
        body = jsonDecode(body);
        body['id'] = json['id'];
        emit(state.copyWith(user: User.fromJson(body)));
      }
      return '';
    } else {
      return 'ErrorCode: ${response.statusCode}\nError:${response.body}';
    }
  }

  FutureOr<String> login(
      {required String username, required String password}) async {
    final loginUrl = Uri.parse('https://fakestoreapi.com/auth/login');
    dynamic body = jsonEncode({
      'username': username,
      'password': password,
    });

    var response = await http.post(loginUrl, headers: headers, body: body);

    if (response.statusCode == 200) {
      print("User Login ${response.body}");
      final json = jsonDecode(response.body);
      emit(state.copyWith(token: json['token']));
      return '';
    } else {
      return 'ErrorCode: ${response.statusCode}\nError:${response.body}';
    }
  }

  FutureOr<void> getProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<Product> productList = [];
      final List products = jsonDecode(response.body);
      productList.addAll(products.map((product) => Product.fromJson(product)));

      /*for(final product in products) {
        productList.add(Product.fromJson(product));
      }*/
      emit(state.copyWith(productList: productList));
    } else {
      print('Failed to load products. ErrorCode: ${response.statusCode}\nError:${response.body}');
    }
  }

  void addToCart(Product product) {
    final List<Product> updatedCart = List<Product>.from(state.cart ?? []);

    final bool alreadyInCart =
        updatedCart.any((cartProduct) => cartProduct.id == product.id);

    if (!alreadyInCart) {
      updatedCart.add(product);
      emit(state.copyWith(cart: updatedCart));
    } else {
      print('Product is already in the cart.');
    }
  }

  bool isProductInCart(Product product) {
    if (state.cart == null) {
      return false;
    }
    return state.cart!.any((cartProduct) => cartProduct.id == product.id);
  }

  void removeFromCart(Product product) {
    if (state.cart == null) {
      return;
    }
    List<Product> updatedCart = List<Product>.from(state.cart!);
    updatedCart.removeWhere((cartProduct) => cartProduct.id == product.id);
    emit(state.copyWith(cart: updatedCart,productList: state.productList));
  }

  String? getName() {
    if(state.user?.id == null ||state.user!.id == 0){
      return null;
    }
    return "${state.user!.name!.firstname!} ${state.user!.name!.lastname!}";
  }


}
