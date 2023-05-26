import 'dart:async';

import 'package:flutter/material.dart';
import 'package:clippy/store/index.dart';
import 'package:clippy/utils/logger.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final TextEditingController _controller = TextEditingController();

  Timer? _debounce;
  void _cancelDebounce() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
  }

  void _listenInput() {
    _cancelDebounce();
    recordStore.setSearchKW(_controller.text);
    _debounce = Timer(const Duration(milliseconds: 200), () async {
      logger.i('search kw ${recordStore.searchKW}');
      recordStore.getRecords(fromInputSearch: true);
    });
  }

  @override
  void initState() {
    _controller.addListener(_listenInput);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _cancelDebounce();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 26,
            width: 360,
            child: TextField(
              controller: _controller,
              cursorWidth: 1,
              style: const TextStyle(fontSize: 13, height: 1),
              decoration: InputDecoration(
                hintText: "搜索",
                filled: true,
                hintStyle: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.4)),
                contentPadding: const EdgeInsets.only(right: 2, left: 2),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 18,
                  color: Colors.grey,
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 28),
                suffixIcon: IconButton(
                  padding: const EdgeInsets.all(0),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  iconSize: 14,
                  onPressed: _controller.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
