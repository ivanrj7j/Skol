import 'package:flutter/material.dart';

class PopUp {
  late String title;
  late Color fg;
  late String message;
  late Color bg;

  PopUp({required this.title, required this.message, this.bg=Colors.amber, this.fg=Colors.white});
  // setting the parameters


  @override
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> build(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Container(
          height: 110,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: this.bg,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.title,
              style: TextStyle(
                color: this.fg,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),),
              // title of the popup


              Text(this.message,
              style: TextStyle(
                  color: this.fg,
                  fontSize: 14
              ),)
              // message of the popup


            ],
          ),
        )
    )
    );
  }
}
