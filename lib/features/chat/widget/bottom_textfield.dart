import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/sizes.dart';

class CustomBottomTextField extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  CustomBottomTextField({super.key});

  void _onEmptyInput() {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      width: size.width,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: 0.5,
            ),
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  clipBehavior: Clip.hardEdge,
                  keyboardType: TextInputType.multiline,
                  controller: _textController,
                  // expands: true,
                  // minLines: null,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: Sizes.size4,
                      horizontal: Sizes.size10,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: _onEmptyInput,
                icon: const Icon(FontAwesomeIcons.xmark),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.arrowLeft),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
