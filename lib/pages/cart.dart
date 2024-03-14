import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/userCubit.dart';
import 'package:test/pages/productpage.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ecommerce App'),
      ),
      body: BlocBuilder<UserCubit, UserData>(
        builder: (BuildContext context, state) {
          if (state.cart == null || state.cart!.isEmpty) {
            return const Center(
                child: Text(
              'Cart is Empty',
              style: TextStyle(fontSize: 14),
            ));
          }
          return ListView.builder(
            itemCount: state.cart!.length,
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
                          state.cart![index].image,
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
                                state.cart![index].title,
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
                                state.cart![index].price,
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Text(
                              maxLines: 3,
                              state.cart![index].description,
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
                          ProductPageView(product: state.cart![index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
