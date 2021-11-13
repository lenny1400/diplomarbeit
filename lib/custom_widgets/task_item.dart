import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.theme, required this.title
  }) : super(key: key);

  final String title;
  final ThemeData theme;


  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
          height: MediaQuery.of(context).size.height*0.09,
          child: Padding(
            padding: EdgeInsets.only(top: 20,left: 40, right: 20),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: theme.canvasColor,
                    primary: theme.backgroundColor,
                    side: BorderSide(
                      width: 1,
                      color: theme.shadowColor,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: theme.textTheme.headline3,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconTheme(
                          data: new IconThemeData(
                              color: theme.shadowColor,
                              size: 35
                          ),
                          child: Icon(Icons.keyboard_arrow_right_sharp),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}