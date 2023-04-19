import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewButton extends StatelessWidget {
  NewButton({required this.buttonText,required this.onPressed});
  String buttonText;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(buttonText),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )))),
      ),
    );
  }
}

class NewInputField extends StatelessWidget {
  NewInputField({super.key, required this.text, required this.icon,required this.onPressed, this.validator});
  String text;
  Icon icon;
  final Function(String) onPressed;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        onChanged: onPressed,
        decoration: InputDecoration(
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10,))),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: text,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            prefixIcon: icon),
        validator: validator,
      ),
    );
  }
}

const spinkit = SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
);