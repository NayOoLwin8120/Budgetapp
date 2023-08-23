import "package:flutter/material.dart";

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.hintText,
    required this.controller,
    required this.validator,
    super.key,
    this.maxline,
    this.onTap,
    this.icon,
    this.labeltext,
    this.filledColor,
    this.textColor,
    this.contentPadding,
    this.isOptional = true,
    this.inputcolor,
    this.isSecure = false,
    this.isNormal = false,
  });
  final bool isNormal;
  final bool isSecure;
  final TextEditingController controller;
  final String hintText;
  final String? labeltext;
  final String? Function(String? value) validator;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? filledColor;
  final Color? textColor;
  final int? maxline;
  final EdgeInsetsGeometry? contentPadding;
  final bool isOptional;
  final Color? inputcolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isOptional)
          const Text(
            "*",
            style: TextStyle(
              color: Colors.red,
              height: -0.5,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        TextFormField(
          maxLines: maxline,
          onTap: onTap,
          obscureText: isSecure,
          scrollPadding: const EdgeInsets.only(bottom: 100),
          validator: validator,
          controller: controller,
          keyboardType: !isNormal
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.emailAddress,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: inputcolor,
          ),
          decoration: InputDecoration(
            errorStyle:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            contentPadding: const EdgeInsets.only(left: 22),
            filled: true,
            fillColor: filledColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xff6633CC)),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Icon(
                icon,
                color: const Color(0xFFFF6633),
              ), // icon is 48px widget.
            ),
            labelText: labeltext,
            labelStyle: TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
