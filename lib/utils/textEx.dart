import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../utils/Utils.dart';

class TextEx extends StatefulWidget {
  const TextEx(this.text, {Key? key, this.style}) : super(key: key);

  final String text;
  final TextStyle? style;

  @override
  _TextExState createState() => _TextExState();
}

class _TextExState extends State<TextEx> {
  @override
  void initState() {
    super.initState();
  }

  bool isEq(String text) {
    bool value = text.toEnglishDigit().contains(RegExp(r"[\d\.\-+\/\*%^]+")) &&
        !text
            .toEnglishDigit()
            .contains(RegExp(r"[ضصثقفغعهخحجچگکمنتالبیسشظطزرذدپو]"));
    // print('${text.toEnglishDigit()} -> $value');
    return value;
  }

  @override
  Widget build(BuildContext context) {
    List<String> texts = widget.text.split(' ');
    // texts = texts.reversed.toList();
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: texts.map((e) {
        bool isTextEq = isEq(e);
        return Text(
          e.toPersianDigit() + (isTextEq ? ' ' : ''),
          style: widget.style,
          // textDirection: isTextEq ? TextDirection.ltr : TextDirection.rtl,
          locale:
              isTextEq ? const Locale("en", "US") : const Locale('fa', 'IR'),
        );
      }).toList(),
    );
  }
}
