import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:clippy/database/type/record.dart';
import 'package:clippy/database/database.dart';
import 'package:clippy/utils/common.dart';

class ImageSize {
  final int width;
  final int height;
  ImageSize(this.width, this.height);
}

class Render extends HookWidget {
  final RecordEntityData item;

  const Render({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isText = item.type == RecordType.text;
    final iscolor = isText ? isColor(item.value) : false;
    final isImage = item.type == RecordType.image;
    final isFile = item.type == RecordType.file;

    String? text = useMemoized(
        () => isText && !iscolor
            ? item.value.length > 450
                ? item.value.substring(0, 450)
                : item.value
            : null,
        []);

    Image? image = useMemoized(
        () => isImage
            ? Image.memory(
                base64.decode(item.thumbnail ?? item.value),
                fit: BoxFit.scaleDown,
                //防止重绘
                gaplessPlayback: true,
              )
            : null,
        []);

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
                isText
                    ? iscolor
                        ? '颜色'
                        : '文本'
                    : isImage
                        ? '图像'
                        : '文件',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                relativeDateFormat(item.updateAt),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
          Image.asset(
            isText
                ? iscolor
                    ? "assets/color.png"
                    : "assets/text.png"
                : isImage
                    ? "assets/pic.png"
                    : "assets/file.png",
            width: 36,
            height: 36,
          )
        ]),
      )
    ];

    if (isFile) {
      children.addAll([
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Image.asset("assets/file-content.png"),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: 16, width: MediaQuery.of(context).size.width),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: MediaQuery.of(context).size.width,
                      height: 16,
                      child: Text(
                        removeFileProtocol(Uri.decodeComponent(item.value))
                            .substring(1),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(10, 19, 18, 0.4),
                        ),
                        maxLines: 1,
                        textDirection: TextDirection.rtl,
                        softWrap: false,
                      ),
                    )
                  ],
                ),
                Text(
                  getFileSizeFormat(item.size!),
                  style: const TextStyle(
                      fontSize: 11, color: Color.fromRGBO(10, 19, 18, 0.4)),
                )
              ],
            ),
          ),
        )
      ]);
    } else if (isImage) {
      children.addAll([
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: image,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              '${item.imgSize} 像素',
              style: const TextStyle(
                  fontSize: 11, color: Color.fromRGBO(10, 19, 18, 0.4)),
            ),
          ),
        )
      ]);
    } else if (!iscolor) {
      children.addAll([
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text!,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 12),
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
