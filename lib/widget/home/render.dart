import 'package:flutter/material.dart';
import 'package:clippy/database/type/record.dart';
import 'package:clippy/database/database.dart';
import 'package:clippy/utils/common.dart';

class Render extends StatelessWidget {
  final RecordEntityData item;

  const Render({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isColor =
        item.type == RECORD_TYPE.text ? isColor(item.value) : false;

    List<Widget> children = [
      Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.type == RECORD_TYPE.text
                    ? _isColor
                        ? '颜色'
                        : '文本'
                    : item.type == RECORD_TYPE.image
                        ? '图像'
                        : '视频',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                relativeDateFormat(item.createAt),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
          Image.asset(
            _isColor ? "assets/color.png" : "assets/text.png",
            width: 36,
            height: 36,
          )
        ]),
      )
    ];

    if (!_isColor) {
      children.addAll([
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            item.value,
            style:
                Theme.of(context).textTheme.headline4?.copyWith(fontSize: 12),
          ),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              '${item.value.length}个字符',
              style: const TextStyle(
                  fontSize: 11, color: Color.fromRGBO(10, 19, 18, 0.4)),
            ),
          ),
        )
      ]);
    } else {
      children.add(
        Expanded(
          child: ColoredBox(
            color: hexToColor(item.value),
            child: Center(
              child: Text(
                item.value,
                style: TextStyle(fontSize: 26, color: reverseColor(item.value)),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: children,
    );
  }
}
