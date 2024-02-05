import 'package:elderlinkz/globals.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatGPTScreen extends StatefulWidget {
  const ChatGPTScreen({ super.key });

  @override
  State<ChatGPTScreen> createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {

  // final buttonKey = GlobalKey();
  // final focusNode = FocusNode();
  // Size buttonSize = const Size(50, 50);

  // Color onBackground = Colors.white;
  // Color background = Colors.black;

  // void runJS(Color textColour) {

  //   String colourHex = "#${textColour.toString().substring(10, 16)}";
  //   debugPrint("test");

  //   controller
  //     .runJavaScript("""

  //       function setup() {

  //         var finished = [ false, false, false ]
  //         // var runIndex = 0

  //         // while (!finished.every(finishedBool => finishedBool) && runIndex < 1000) {

  //         //   runIndex += 1

  //           console.log(finished)

  //           var bottomText = document.getElementsByClassName('relative px-2 py-2 text-center text-xs text-token-text-secondary md:px-[60px]');
  //           var message = document.getElementsByClassName('w-full text-token-text-primary');
  //           var ChatGPTMsg = document.getElementsByClassName('markdown prose w-full break-words dark:prose-invert dark');

  //           if (bottomText.length > 0) {
              
  //             bottomText[0].innerHTML = ''
  //             finished[0] = true
              
  //           }

  //           if (message.length > 0) {
              
  //             for (var i = 0; i < message.length; i++) {
  //               if (message[i].className === 'w-full text-token-text-primary') {

  //                 message[i].style.color = '$colourHex'
  //                 finished[1] = true

  //               }
  //             }

  //             for (var i = 0; i < ChatGPTMsg.length; i++) {
  //               ChatGPTMsg[i].style.color = '$colourHex'
  //               finished[2] = true
  //             }

  //           }

  //         }

  //       // }

  //       setInterval(setup, 1000)

  //     """);

  // }

  @override
  void initState() {
    
    // SchedulerBinding.instance
    //   .addPostFrameCallback((timeStamp) {

    //     setState(() {

    //       buttonSize = buttonKey.currentContext?.size ??
    //         const Size(50, 50);

    //     });

    //   });

    controller = WebViewController()
      // ..setBackgroundColor(background)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://chat.openai.com/'));
      // ..setNavigationDelegate(
      //   NavigationDelegate(
      //     onPageFinished: (url) {
      //       runJS(onBackground);
      //       debugPrint("onPageFinished");
      //     },
      //     onUrlChange: (url) {
      //       runJS(onBackground);
      //       debugPrint("onUrlChange");
      //     },
      //   )
      // );

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    // ColorScheme colorScheme = Theme.of(context).colorScheme;
    // onBackground = colorScheme.onBackground;
    // background = colorScheme.onBackground;

    // debugPrint(colorScheme.surface.toString().substring(10, 16));
      

    return Layout(
      title: "Chatbot",
      backButton: true,
      bottomNavbar: false,
      body: WebViewWidget(controller: controller),
    );

    // return Scaffold(
    //   body: WebViewWidget(controller: controller),
    //   body: Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(20),
    //             border: focusNode.hasFocus ?
    //               Border.all(
    //                 width: 2,
    //                 color: colorScheme.primary,
    //               ) :
    //               Border.all(
    //                 width: 2,
    //                 color: colorScheme.onSurface,
    //               )
    //           ),
    //           child: Row(
    //             children: [
    //               SizedBox(
    //                 width: screenSize.width - 44 - buttonSize.width,
    //                 child: TextFormField(
    //                   focusNode: focusNode,
    //                   decoration: InputDecoration(
    //                     label: Container(
    //                       color: colorScheme.background,
    //                       child: const Padding(
    //                         padding: EdgeInsets.all(5.0),
    //                         child: Text("Ask ChatGPT",),
    //                       ),
    //                     ),
    //                     focusColor: colorScheme.surface,
    //                     enabledBorder: const OutlineInputBorder(
    //                       borderSide: BorderSide(width: 0)
    //                     ),
    //                     focusedBorder: const OutlineInputBorder(
    //                       borderSide: BorderSide(width: 0)
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               IconButton(
    //                 key: buttonKey,
    //                 icon: const Icon(Icons.send),
    //                 onPressed: () {
              
    //                 },
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );

  }

}