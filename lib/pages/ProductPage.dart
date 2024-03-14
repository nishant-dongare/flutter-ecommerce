import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/userCubit.dart';
import 'package:test/models/product.dart';

class ProductPageView extends StatelessWidget {
  final Product product;
  const ProductPageView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool isAdded = BlocProvider.of<UserCubit>(context).isProductInCart(product);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Image.network(
                  product.image,
                  height: 400,
                  width:400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.price,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 50),

            Center(
              child: ElevatedButton(
                onPressed: (){
                  if(isAdded) {
                    BlocProvider.of<UserCubit>(context).addToCart(product);
                  }else{
                    BlocProvider.of<UserCubit>(context).removeFromCart(product);
                  }
                },
                child: Text(isAdded?'Remove':'Add to Cart'),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
