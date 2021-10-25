import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_nav_bar/screens/home/Screens_Home/all_tasks.dart';

class HomeBet350N400 extends StatefulWidget {
  const HomeBet350N400({Key? key, required this.constraint}) : super(key: key);

  final constraint;

  @override
  _HomeBet350N400State createState() => _HomeBet350N400State();
}

class _HomeBet350N400State extends State<HomeBet350N400> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final constraintX = widget.constraint;
    return Center(
      child: FittedBox(
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        child: Container(
          height: constraintX*1,
          width: MediaQuery.of(context).size.width*1,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: constraintX*0.02,top: constraintX*0.01),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    constraintX.toString(),
                    style: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: constraintX*0.025
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: constraintX*0.02,left: constraintX*0.09),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Not finished',
                    style: TextStyle(
                        color: theme.dividerColor,
                        fontSize: constraintX*0.04,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: constraintX*0.09, right: constraintX*0.05,top: constraintX*0.015,bottom: constraintX*0.015),
                child: Container(
                  height: constraintX*0.09,
                  width: MediaQuery.of(context).size.width*1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: theme.canvasColor,
                          primary: theme.backgroundColor,
                          side: BorderSide(
                            width: 1,
                            color: theme.dividerColor,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: constraintX*0.01),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Adidas-12-08-Server",
                                  style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.025,
                                  ),
                                ),
                              ),
                            ),
                            flex: 3,
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Tap to see",
                                style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.015
                                ),
                              ),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: constraintX*0.05, right: constraintX*0.03,),
                child: Container(
                  width: MediaQuery.of(context).size.width*1,
                  height: constraintX*0.09,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: theme.backgroundColor,
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => AllTasksPage(title: 'All Tasks',)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: constraintX*0.02),
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.dividerColor,
                                      fontSize: constraintX*0.04
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconTheme(
                              data: new IconThemeData(
                                  color: theme.dividerColor,
                                  size: constraintX*0.06
                              ),
                              child: Icon(Icons.keyboard_arrow_right_sharp),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: constraintX*0.01, left: constraintX*0.09),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Finished Contracts',
                    style: TextStyle(
                        color: theme.dividerColor,
                        fontSize: constraintX*0.04,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: constraintX*0.09, right: constraintX*0.05,top: constraintX*0.015,bottom: constraintX*0.015),
                child: Container(
                  height: constraintX*0.09,
                  width: MediaQuery.of(context).size.width*1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: theme.canvasColor,
                          primary: theme.backgroundColor,
                          side: BorderSide(
                            width: 1,
                            color: theme.dividerColor,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: constraintX*0.01),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Adidas-12-08-Server",
                                  style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.025,
                                  ),
                                ),
                              ),
                            ),
                            flex: 3,
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Tap to see",
                                style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.015
                                ),
                              ),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: constraintX*0.09, right: constraintX*0.05,top: constraintX*0.015,bottom: constraintX*0.015),
                child: Container(
                  height: constraintX*0.09,
                  width: MediaQuery.of(context).size.width*1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: theme.canvasColor,
                          primary: theme.backgroundColor,
                          side: BorderSide(
                            width: 1,
                            color: theme.dividerColor,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: constraintX*0.01),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Adidas-12-08-Server",
                                  style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.025,
                                  ),
                                ),
                              ),
                            ),
                            flex: 3,
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Tap to see",
                                style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.015
                                ),
                              ),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: constraintX*0.09, right: constraintX*0.05,top: constraintX*0.015,bottom: constraintX*0.015),
                child: Container(
                  height: constraintX*0.09,
                  width: MediaQuery.of(context).size.width*1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: theme.canvasColor,
                          primary: theme.backgroundColor,
                          side: BorderSide(
                            width: 1,
                            color: theme.dividerColor,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: constraintX*0.01),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Adidas-12-08-Server",
                                  style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.025,
                                  ),
                                ),
                              ),
                            ),
                            flex: 3,
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Tap to see",
                                style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.015
                                ),
                              ),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: constraintX*0.09, right: constraintX*0.05,top: constraintX*0.015,bottom: constraintX*0.015),
                child: Container(
                  height: constraintX*0.09,
                  width: MediaQuery.of(context).size.width*1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: theme.canvasColor,
                          primary: theme.backgroundColor,
                          side: BorderSide(
                            width: 1,
                            color: theme.dividerColor,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: constraintX*0.01),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Adidas-12-08-Server",
                                  style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.025,
                                  ),
                                ),
                              ),
                            ),
                            flex: 3,
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Tap to see",
                                style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: constraintX*0.015
                                ),
                              ),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: constraintX*0.06, right: constraintX*0.03,),
                child: Container(
                  width: MediaQuery.of(context).size.width*1,
                  height: constraintX*0.09,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: theme.backgroundColor,
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => AllTasksPage(title: 'All Tasks',)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: constraintX*0.02),
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.dividerColor,
                                      fontSize: constraintX*0.04
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconTheme(
                              data: new IconThemeData(
                                  color: theme.dividerColor,
                                  size: constraintX*0.06
                              ),
                              child: Icon(Icons.keyboard_arrow_right_sharp),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}