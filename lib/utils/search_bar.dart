import 'package:flutter/material.dart';
import 'package:image/screens/search_screens.dart';

class SearchBar extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "result");
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchScreen(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Image(
        image: AssetImage("assets/images/1200x1200.gif"),
        height: 200,
        width: 200,
      ),
    );
  }
}
