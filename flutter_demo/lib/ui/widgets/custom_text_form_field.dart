import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String> onChanged; 

  const CustomTextFormField({
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.obscureText = false,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        icon: Icon(icon),
        hintText: hintText,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }

}