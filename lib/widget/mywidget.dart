import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/colors.dart';

class CustomTextFiled extends StatelessWidget {
  String headingText;
  String hintText;
  TextEditingController? controller = TextEditingController();
  Widget suffix;
  Widget preffix;
  Function isValid;
  Function? onChanged;
  String errorMessage;
  bool obscureText;
  TextInputType keyboardType;
  List<TextInputFormatter>? inputFormatters;

  CustomTextFiled(
      {Key? key,
      this.inputFormatters,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.errorMessage = "Invalid Value",
      required this.isValid(String val),
      this.onChanged(String val)?,
      this.suffix = const SizedBox(),
      this.preffix = const SizedBox(),
      required this.headingText,
      this.controller,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headingText,
          style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          child: TextFormField(
            keyboardType: keyboardType,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => isValid(value) ? null : errorMessage,
            onChanged: (value) => onChanged != null ? onChanged!(value) : {},
            controller: controller,
            cursorColor: Theme.of(context).primaryColor,
            style: TextStyle(
                letterSpacing: 1.5,
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                errorStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.red,
                    fontWeight: FontWeight.w500),
                hintText: hintText,
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      // width: 0.9,
                      color: Theme.of(context).highlightColor), //<-- SEE HERE
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: .7,
                      color: Theme.of(context).highlightColor), //<-- SEE HERE
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.5,
                      color: Theme.of(context).highlightColor), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      // width: 0.5,
                      color: Theme.of(context).highlightColor), //<-- SEE HERE
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.5,
                      color: Theme.of(context).highlightColor), //<-- SEE HERE
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.5,
                      color: Theme.of(context).highlightColor), //<-- SEE HERE
                ),
                suffixIcon: suffix,
                prefixIcon: preffix),
          ),
        )
      ],
    );
  }
}

showLoading() {
  return Center(
    child: CircularProgressIndicator(color: indigo),
  );
}

CustomContainer(Widget child) {
  return Container(
    height: 50,
    width: 250,
    decoration: BoxDecoration(
        border: Border.all(), borderRadius: BorderRadius.circular(10)),
    child: child,
  );
}
