import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    super.key,
    required this.sectionTitle,
    required this.sectionWidgets,
    this.leftArrow = false,
    this.rightArrow = false,
    this.toPersonalTab,
    this.toHealthTab,
  });

  final String sectionTitle;
  final List<Widget> sectionWidgets;
  final bool leftArrow, rightArrow;
  final void Function()? toHealthTab, toPersonalTab;
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            if (rightArrow && toHealthTab != null) Positioned(
              top: 0,
              bottom: 0,
              right: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.arrowRight,
                      size: 30,
                    ),
                    onPressed: toHealthTab,
                  ),
                ],
              ),
            ),
            if (leftArrow && toPersonalTab != null) Positioned(
              top: 0,
              bottom: 0,
              left: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: 30,
                    ),
                    onPressed: toPersonalTab,
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leftArrow) const SizedBox(width: 30),
                Container(
                  width: screenSize.width - 60 - (rightArrow ? 30 : 0) - (leftArrow ? 30 : 0),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorScheme.secondary
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sectionTitle,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      ...sectionWidgets
                    ],
                  ),
                ),
                if (rightArrow) const SizedBox(width: 30),
              ] 
            ),
          ],
        ),
      ],
    );
  }
}