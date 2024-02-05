import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/functions/get_text_size.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsCard extends StatelessWidget {

  const DetailsCard({
    super.key,
    required this.sectionTitle,
    required this.patient,
    this.child,
    this.leftArrow = false,
    this.rightArrow = false,
    this.toPreviousTab,
    this.toNextTab,
  });

  final String sectionTitle;
  final Widget? child;
  final Patient patient;
  final bool leftArrow, rightArrow;
  final void Function()? toNextTab, toPreviousTab;
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: screenSize.width,
      child: Stack(
        children: [
          if (rightArrow && toNextTab != null)
            ChangeTabArrow(
              right: rightArrow,
              switchTabFunc: toNextTab!,
            ),
          if (leftArrow && toPreviousTab != null)
            ChangeTabArrow(
              right: !leftArrow,
              switchTabFunc: toPreviousTab!,
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leftArrow) const SizedBox(width: 30),
              SizedBox(
                width: screenSize.width - 60 - (rightArrow ? 30 : 0) - (leftArrow ? 30 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0,),
                      child: Text(sectionTitle,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    child ??
                      Container()
                  ],
                ),
              ),
              if (rightArrow) const SizedBox(width: 30),
            ] 
          ),
        ],
      ),
    );
  }
}

class ChangeTabArrow extends StatelessWidget {
  const ChangeTabArrow({
    super.key,
    required this.right,
    required this.switchTabFunc,
  });
  
  final bool right;
  final void Function() switchTabFunc;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: right ?
        15 :
        null,
      left: !right ?
        15 :
        null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              right ?
                FontAwesomeIcons.arrowRight :
                FontAwesomeIcons.arrowLeft,
              size: 30,
            ),
            onPressed: switchTabFunc,
          ),
        ],
      ),
    );
  }
}

class DetailListTile extends StatelessWidget {
  
  const DetailListTile({
    super.key,
    required this.width,
    required this.height,
    required this.titleText,
    this.child,
  });
  
  final double width, height;
  final String titleText;
  final Widget? child;
  final listTextStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Positioned.fill(
          left: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(titleText,
                style: listTextStyle,
              ),
            ),
          )
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: SizedBox(
            height: height - 20,
            width: width - textSize(
              titleText,
              listTextStyle
            ).width - 30,
            child: child ??
                Container(),
          ),
        ),
      ],
    );

  }
  
}

class DetailGridTile extends StatelessWidget {
  
  const DetailGridTile({
    super.key,
    required this.width,
    required this.height,
    this.icon,
    this.title,
    this.value,
    this.child,
    this.background = true,
  });
  
  final double width, height;
  final IconData? icon;
  final String? title, value;
  final Widget? child;
  final bool background;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: background ?
            BoxDecoration(
              color: colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(10)
            ) :
            null,
          child: child ??
            Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Row(
                    children: [
                      Text(title ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(icon,
                            size: textSize(title ?? "",
                            const TextStyle(fontWeight: FontWeight.bold)
                          ).height,
                        ),
                      )
                    ],
                  )
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(value ?? "",
                    style: TextStyle(
                      fontSize: textSize(title ?? "",
                        const TextStyle(fontWeight: FontWeight.bold)
                      ).height * 1.5
                    ),
                  )
                )
              ]
            ),
        ),
      ),
    );
  }
  
}