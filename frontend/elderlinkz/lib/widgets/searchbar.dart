import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged
  });

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {

    // Colourscheme
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SearchBar(
        controller: controller,
        onChanged: onChanged,
        leading: Icon(Icons.search, color: colorScheme.primary,),
        textStyle: MaterialStatePropertyAll(TextStyle(color: colorScheme.background)),
        shadowColor: MaterialStatePropertyAll(colorScheme.onBackground),
        padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 20)),
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        side: MaterialStatePropertyAll(BorderSide(color: colorScheme.onBackground, width: .25)),
      ),
    );
  }
}