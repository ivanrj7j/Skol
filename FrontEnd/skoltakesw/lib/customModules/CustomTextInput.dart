import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  late String placeHolderText;
  late IconData icon;
  late Color color, backgroundColor, textColor;
  late EdgeInsets padding;
  late void Function(String text) changeFunction;
  late bool isPassword;


  CustomTextInput(this.placeHolderText, this.icon, this.changeFunction, {Key? key, this.color = Colors.amber, this.padding= const EdgeInsets.all(30.0), this.isPassword = false, this.backgroundColor=Colors.white10, this.textColor=Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget returnObject = Padding(
      padding: padding,
      child:
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: backgroundColor,
            ),
            child: TextFormField(
              style: TextStyle(color: this.color),
              obscureText: isPassword,
              onChanged: changeFunction,
              autocorrect: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeHolderText,
                hintStyle: TextStyle(
                  color: textColor
                ),
                prefixIcon: Icon(icon, color: color,),
              ),
            ),
          )

    );;


    return returnObject;
  }
}
