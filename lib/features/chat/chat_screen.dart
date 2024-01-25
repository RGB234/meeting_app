import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/chat/widget/message.dart';
import 'dart:ui' as ui;

class ChatScreen extends StatefulWidget {
  static const routeName = "chat";
  static const routeRoute = "chat";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextStyle _textFieldTextStyle = const TextStyle(fontSize: Sizes.size16);
  final GlobalKey _globalKey = GlobalKey();
  double _textFieldHeight = Sizes.size80;

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onEmptyInput() {
    _textController.clear();
  }

  void _autogrowTextField() {
    const double baseHeight = Sizes.size80;
    const double maxHeigth = 160;
    List<String> substrs = _textController.text.split("\n");
    int lineBreaks = 0;

    // calculate line breaks
    for (final substr in substrs) {
      lineBreaks += (_calcStringWidth(substr) / _calcTextFieldWidth()).floor();
    }
    lineBreaks += substrs.length - 1;

    // calculate _textFieldHeight
    _textFieldHeight = baseHeight + 20 * lineBreaks;

    // _textFieldHeight upperbound
    if (_textFieldHeight > maxHeigth) {
      _textFieldHeight = maxHeigth;
    }
  }

  double _calcStringWidth(String text) {
    double stringWidth = 0.0;
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: _textFieldTextStyle,
      ),
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout();
    stringWidth = textPainter.width;
    print("string width : $stringWidth");
    return stringWidth;
  }

  double _calcTextFieldWidth() {
    double textFieldWidth = 0.0;
    if (_globalKey.currentContext != null) {
      RenderBox renderbox =
          _globalKey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderbox.size;
      textFieldWidth = size.width;
      print("textFieldWidth : $textFieldWidth");
    } else {
      print("currentContext is null");
      textFieldWidth = MediaQuery.of(context).size.width * 0.7;
    }
    return textFieldWidth;
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      _autogrowTextField();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Scrollbar(
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  left: Sizes.size10,
                  right: Sizes.size10,
                  top: Sizes.size24,
                  bottom: Sizes.size96,
                ),
                itemCount: 7,
                itemBuilder: (context, index) {
                  if (index % 3 == 0) {
                    return const Message(
                      isMyMessage: true,
                    );
                  }
                  return const Message();
                },
                separatorBuilder: (context, index) => Gaps.v16,
              ),
            ),
            Positioned(
              height: _textFieldHeight,
              width: size.width,
              bottom: 0,
              child: BottomAppBar(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        key: _globalKey,
                        clipBehavior: Clip.hardEdge,
                        keyboardType: TextInputType.multiline,
                        controller: _textController,
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        style: _textFieldTextStyle,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: Sizes.size4,
                            horizontal: Sizes.size10,
                          ),
                        ),
                      ),
                    ),
                    Gaps.h12,
                    GestureDetector(
                      onTap: _onEmptyInput,
                      child: const FaIcon(FontAwesomeIcons.xmark),
                    ),
                    Gaps.h12,
                    const FaIcon(FontAwesomeIcons.arrowLeft),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
