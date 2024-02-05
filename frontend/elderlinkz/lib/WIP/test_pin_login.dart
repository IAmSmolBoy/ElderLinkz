import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinLogin extends StatefulWidget {
  const PinLogin({ super.key });

  @override
  State<PinLogin> createState() => _PinLoginState();
}

class _PinLoginState extends State<PinLogin> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  bool pass = false;

  @override
  Widget build(BuildContext context) {

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  height: screenSize.height / 1.5,
                  width: screenSize.width / 1.1,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 8,
                      right: 8,
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/Elderlinkz Logo.png',
                          height: screenSize.height / 5,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.5),
                          child: Text("Pin",
                            style: TextStyle(
                              fontSize: 23,
                              letterSpacing: .5
                            ),
                          ),
                        ),
                        Pinput(
                          controller: _pinController,
                          // defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => const SizedBox(width: 8),
                          validator:
                            (value) =>
                              value == '2222555' ?
                                null :
                                'Pin is incorrect',
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                // color: focusedBorderColor,
                              ),
                            ],
                          ),
                          // focusedPinTheme: defaultPinTheme.copyWith(
                          //   decoration: defaultPinTheme.decoration!.copyWith(
                          //     borderRadius: BorderRadius.circular(8),
                          //     border: Border.all(color: focusedBorderColor),
                          //   ),
                          // ),
                          // submittedPinTheme: defaultPinTheme.copyWith(
                          //   decoration: defaultPinTheme.decoration!.copyWith(
                          //     color: fillColor,
                          //     borderRadius: BorderRadius.circular(19),
                          //     border: Border.all(color: focusedBorderColor),
                          //   ),
                          // ),
                          // errorPinTheme: defaultPinTheme.copyBorderWith(
                          //   border: Border.all(color: Colors.redAccent),
                          // ),
                        ),
                        // TextFormField(
                        //   validator: emailValidator,
                        //   controller: _emailController,
                        //   // style: TextStyle(color: Style.black),
                        //   decoration: InputDecoration(
                        //     hintText: 'Enter Email id',
                        //     // hintStyle: TextStyle(color: Style.grey),
                        //     prefixIcon: const Icon(
                        //       Icons.email,
                        //       // color: Style.grey,
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       // borderSide: BorderSide(color: Style.grey),
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     border: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(20),
                        //       ),
                        //       // borderSide: new BorderSide(color: Style.grey),
                        //     ),
                        //     focusedBorder: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(20),
                        //       ),
                        //       borderSide: BorderSide(width: 1),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 8.5,),
                        // TextFormField(
                        //   validator: passwordValidator,
                        //   controller: _passwordController,
                        //   obscureText: !pass,
                        //   // style: TextStyle(color: Style.black),
                        //   decoration: InputDecoration(
                        //     hintText: 'Enter Password',
                        //     // hintStyle: TextStyle(color: Style.grey),
                        //     prefixIcon: IconButton(
                        //       onPressed: toggleVisibility,
                        //       icon: Icon(
                        //         pass ?
                        //           Icons.visibility :
                        //           Icons.visibility_off,
                        //         // color: Style.grey,
                        //       ),
                        //     ),
              
                        //     // Icon(
                        //     //   Icons.lock,
                        //     //   color: Style.grey,
                        //     // ),
                        //     enabledBorder: OutlineInputBorder(
                        //       // borderSide: BorderSide(color: Style.grey),
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     border: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(20),
                        //       ),
                        //       // borderSide: new BorderSide(color: Style.grey),
                        //     ),
                        //     focusedBorder: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(20),
                        //       ),
                        //       borderSide: BorderSide(width: 1),
                        //     ),
                        //   ),
                        // ),
                        // Row(
                        //   children: [
                            // Checkbox(
                            //   // activeColor: Style.white,
                            //   // autofocus: true,
                            //   // focusColor: Style.white,
                            //   // checkColor: Style.black,
                            //   value: providerFalse!.value,
                            //   side: MaterialStateBorderSide.resolveWith(
                            //     (Set<MaterialState> states) {
                            //       if (states
                            //           .contains(MaterialState.selected)) {
                            //         return const BorderSide(
                            //             width: 2, color: Colors.grey);
                            //       }
                            //       return const BorderSide(
                            //           width: 1, color: Colors.grey);
                            //     },
                            //   ),
                            //   onChanged: (newValue) {
                            //     providerFalse!.change_checkbox(newValue);
                            //   },
                            // ),
                            // const Text(
                            //   "Remember me",
                            //   // style: TextStyle(color: Style.grey),
                            // ),
                            // const Spacer(),
                            // TextButton(
                            //   onPressed: () {
                            //     Provider.of<ChangePasswordProvider>(context,
                            //             listen: false)
                            //         .change_new_pass
                            //         .clear();
                            //     Provider.of<ChangePasswordProvider>(context,
                            //             listen: false)
                            //         .change_password
                            //         .clear();
                            //     Provider.of<ChangePasswordProvider>(context,
                            //             listen: false)
                            //         .change_re_new_pass
                            //         .clear();
              
                            //     Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //           ChangePasswordPage(),
                            //       ),
                            //     );
                            //   },
                            //   child: const Text("Change Password"),
                            // ),
                        //   ],
                        // ),
                        // const SizedBox(height: 8.5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          child: SizedBox(
                            width: screenSize.width,
                            height: screenSize.height / 14.7,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: onSave,
                              child: const Text(
                                "Login",
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 8.5,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "Have Not Account Yet?",
                        //       style:
                        //           // TextStyle(color: Style.black, fontSize: 15),
                        //     ),
                        //     TextButton(
                        //       onPressed: () {
                        //         Navigator.pushReplacement(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const RegistrationPage(),
                        //           ),
                        //         );
                        //       },
                        //       child: const Text("Create Account"),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }












  // Functions
  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "PLease Enter Your Email";
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "PLease Enter Your Password";
    }
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
      return "Please enter a valid Password";
    } else {
      return null;
    }
  }

  void toggleVisibility() {
    setState(() {
      pass = !pass;
    });
  }

  void onSave() async {
    // String? email = await readEmail();
    // String? password = await readPassword();

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      
    }
  }
}