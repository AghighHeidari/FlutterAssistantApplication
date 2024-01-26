import 'package:flutter/cupertino.dart';

Widget gridViewEx(
    {required BuildContext context,
    required int itemCount,
    bool shrinkWrap = true,
    required int rowCount,
    required List<Widget> items,
    double listViewBottomPadding = 0,
    ScrollPhysics scrollPhysics = const NeverScrollableScrollPhysics()}) {
  return ListView.builder(
    padding: EdgeInsets.only(bottom: listViewBottomPadding),
    shrinkWrap: shrinkWrap,
    itemCount: (itemCount ~/ rowCount) + (itemCount % rowCount == 0 ? 0 : 1),
    physics: scrollPhysics,
    itemBuilder: (context, index) {
      int colCount =
          (itemCount ~/ rowCount) + (itemCount % rowCount == 0 ? 0 : 1);
      if (index == colCount - 1) {
        int count = itemCount % rowCount;
        return Row(
          children: items
              .getRange(index * rowCount, index * rowCount + count)
              .map((e) => Expanded(child: e))
              .toList()
            ..addAll(List.filled(
                rowCount - count,
                Expanded(
                  child: Container(),
                ))),
        );
      } else {
        return Row(
          children: items
              .getRange(index * rowCount, index * rowCount + rowCount)
              .map((e) => Expanded(child: e))
              .toList(),
        );
      }
    },
  );
}
