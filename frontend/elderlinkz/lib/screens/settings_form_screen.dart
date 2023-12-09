import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';

class SettingsFormScreen extends StatefulWidget {
  SettingsFormScreen({
    super.key,
    required this.settingName,
    required this.initialVal,
    required this.save,
  });

  final String settingName, initialVal;
  final void Function(String) save;

  @override
  State<SettingsFormScreen> createState() => _SettingsFormScreenState();
}

class _SettingsFormScreenState extends State<SettingsFormScreen> {

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget.initialVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    return Layout(
      title: widget.settingName,
      bottomNavbar: false,
      settingsButton: false,
      backButton: true,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: _textController,
                  onTapOutside: (event) { FocusManager.instance.primaryFocus?.dispose(); },
                  decoration: InputDecoration(
                    hintText: widget.settingName,
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
                    if (_formKey.currentState!.validate()) {
                      widget.save(_textController.text);

                      Navigator.maybePop(context);
                    }
                  },
                  child: Text("Save",
                    style: TextStyle(color: colorScheme.onBackground),
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}