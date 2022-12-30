import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  late Widget child;
  late void Function() onClickFunction;
  late IconData icon;
  late bool needIcon;
  late Color backgroundColor;
  late Color textColor;

  CustomElevatedButton(this.child, this.onClickFunction, {Key? key, this.needIcon=false, this.icon=Icons.add, required this.backgroundColor, this.textColor=Colors.amber}) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {

    Widget label = Padding(
      padding: const EdgeInsets.all(12),
      child: widget.child,
    );

    void updateLabel(Widget newLabel){
      setState(() {
        label = newLabel;
      });
    }

    Widget completedButton;
    if (!widget.needIcon) {
      completedButton = ElevatedButton(
          onPressed: widget.onClickFunction,
          child: label,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(widget.backgroundColor),
          ),
      );
    }else{
      completedButton = ElevatedButton.icon(onPressed: widget.onClickFunction,
          icon: Icon(widget.icon),
          label: label,
          style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.backgroundColor),
    ),
      );
    }

    return completedButton;
  }
}
