import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/userCubit.dart';
import 'package:test/pages/ProductPage.dart';
import 'package:test/widgets/searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserCubit userCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ecommerce App'),
        actions: [
          IconButton(
            onPressed: () {
              final productlist = userCubit.state.productList;
              if (productlist == null) return;
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(items: productlist),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.filter_alt),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'cart');
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: BlocBuilder<UserCubit, UserData>(
          builder: (BuildContext context, state) {
        if (state.productList == null) {
          //print("state.productList == null");
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: state.productList?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: Image.network(
                        height: 120,
                        width: 120,
                        state.productList![index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Column(
                        children: [
                          Align(
                            alignment:Alignment.centerLeft,
                            child: Text(
                              state.productList![index].title,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.productList![index].price,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            maxLines: 3,
                            state.productList![index].description,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductPageView(product: state.productList![index]),
                  ),
                );
              },
            );
          },
        );
      }),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                userCubit.getName() ??
                    "Guest", // Replace with the actual username
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(userCubit.state.user?.email ?? "guest@email"),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'login'); // Replace 'login' with your actual login screen route
              },
            ),

          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    if (userCubit.state.productList == null) {
      print("userCubit.getProducts();");
      userCubit.getProducts();
    }
  }
}
