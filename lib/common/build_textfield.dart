// ignore_for_file: camel_case_extensions

import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String label;
  bool obsureText;
  bool enabled;
  final String hinttext;
  final TextInputType inputtype;
  TextEditingController c;
  final int maxchars;
  final int maxlines;
  final String? Function(String?)? validator;

  CustomTextField(
      {Key? key,
      required this.label,
      required this.validator,
      required this.c,
      this.maxchars = 99,
      this.obsureText = false,
      this.enabled = true,
      required this.hinttext,
      this.maxlines = 1,
      required this.inputtype})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: sh * 0.01,
        ),
        TextFormField(
          onTap: () {
            if (widget.c.selection ==
                TextSelection.fromPosition(
                    TextPosition(offset: widget.c.text.length - 1))) {
              setState(() {
                widget.c.selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.c.text.length));
              });
            }
          },
          obscureText: widget.obsureText ? _obscureText : false,
          keyboardType: widget.inputtype,
          validator: widget.validator,
          maxLength: widget.maxchars,
          controller: widget.c,
          enabled: widget.enabled,
          maxLines: widget.maxlines,
          style: TextStyle(color: widget.enabled ? null : Colors.grey[400]),
          decoration: InputDecoration(
            hintText: widget.hinttext,
            counterText: "",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 3, color: primary),
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            suffixIcon: widget.obsureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: _obscureText ? Colors.grey : primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

extension extString on String {
  bool get isValidName {
    final nameRegExp = RegExp(r'^[\u0600-\u06FF\s]+$');
    return nameRegExp.hasMatch(this);
    // return this.isNotEmpty;
  }

  bool get isValidPassword {
    return isEmpty;
  }

  bool get isValidEmail {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^09\d{8}$");
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidNational {
    final natRegExp = RegExp(r"^\d{11}$");
    return natRegExp.hasMatch(this);
  }
}
