import 'package:elderlinkz/classes/tile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    super.key,
    required this.sectionTitle,
    required this.tiles,
    this.leftArrow = false,
    this.rightArrow = false,
    this.toPersonalTab,
    this.toHealthTab,
  });

  final String sectionTitle;
  final List<TileData> tiles;
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
                      SizedBox(
                        height: screenSize.height * .6 - 60,
                        child: StaggeredGrid.extent(
                          // crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          axisDirection: AxisDirection.right,
                          maxCrossAxisExtent: (screenSize.width - 60 - (rightArrow ? 30 : 0) - (leftArrow ? 30 : 0)),
                          children: tiles
                            .map(
                              (tile) =>
                                StaggeredGridTile
                                  .extent(
                                    crossAxisCellCount: tile.crossAxisCellCount,
                                    mainAxisExtent: (screenSize.width - 60 - 30) / 4 * (tile.mainAxisCellCount),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: colorScheme.onSecondary,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 10,
                                            left: 10,
                                            child: Text(tile.title ?? "",
                                              style: TextStyle(
                                                color: colorScheme.background
                                              ),
                                            )
                                          ),
                                          Center(
                                            child: CircleAvatar(
                                              backgroundColor: colorScheme.onSecondary,
                                              foregroundColor: colorScheme.background,
                                              child: Text(tile.value ?? ""),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                            )
                            .toList()
                        ),
                        // child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: sectionWidgets,
                        // ),+
                      )
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