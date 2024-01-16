class TileData {

  final int crossAxisCellCount;
  final int mainAxisCellCount;
  final String? title;
  final String? value;

  const TileData({
    required this.crossAxisCellCount,
    required this.mainAxisCellCount,
    this.title,
    this.value
  });

}