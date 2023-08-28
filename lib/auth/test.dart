import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutocompleteExample extends StatefulWidget {
  @override
  _AutocompleteExampleState createState() => _AutocompleteExampleState();
}

class _AutocompleteExampleState extends State<AutocompleteExample> {
  final TextEditingController _controller = TextEditingController();

  // Sample list of suggestions
  final List<String> _suggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grape',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Pear',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autocomplete Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Fruit',
            ),
          ),
          suggestionsCallback: (pattern) {
            return _suggestions.where((fruit) =>
                fruit.toLowerCase().contains(pattern.toLowerCase()));
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
            _controller.text = suggestion;
          },
        ),
      ),
    );
  }
}
