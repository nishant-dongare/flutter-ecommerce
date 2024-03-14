import 'package:flutter/material.dart';
import 'package:test/models/product.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Product> items;

  CustomSearchDelegate({required this.items});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchQuery = [];
    for (var item in items) {
      if (item.title.toLowerCase().contains(query.toLowerCase()) || item.category.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Image.network(
                height: 120,
                width: 120,
                matchQuery[index].image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Text(
                matchQuery[index].title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];
    for (final item in items) {
      if (item.title.toLowerCase().contains(query.toLowerCase())  || item.category.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Image.network(
                height: 120,
                width: 120,
                matchQuery[index].image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Text(
                matchQuery[index].title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}

