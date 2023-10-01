// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:earthquake/constants/colors.dart';
import 'package:flutter/material.dart';

class ScrollUpButton extends StatelessWidget {
  VoidCallback callback;
  ScrollUpButton({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 50,
        height: 50,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: Colors.grey.withOpacity(.5),
                blurRadius: 12)
          ],
          color: primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
        ),
      ),
    );
  }
}
