import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';

class SettingsFormScreen extends StatelessWidget {
  const SettingsFormScreen({
    super.key,
    required this.settingName,
    required this.initialVal
  });

  final String settingName, initialVal;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    return Layout(
      title: settingName,
      bottomNavbar: false,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  onTapOutside: (event) { FocusManager.instance.primaryFocus?.dispose(); },
                  decoration: InputDecoration(
                    hintText: settingName,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.onBackground),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.primary),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.error),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  )
                ),
                const SizedBox(height: 25,),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: Text("Save",
                    style: TextStyle(color: colorScheme.onBackground),),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}