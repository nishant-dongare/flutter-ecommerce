import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ecommerce App'),
        actions: [
          IconButton(
            onPressed: () {
              final productlist =
                  BlocProvider.of<UserCubit>(context).state.productList;
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
              Navigator.pushNamed(context, 'cart');
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: BlocBuilder<UserCubit, UserData>(
          builder: (BuildContext context, state) {
        if (state.productList == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: state.productList?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
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
                    child: Text(
                      state.productList![index].title,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductPageView(product: state.productList![index])),
                );
              },
            );
          },
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getProducts();
  }
}
