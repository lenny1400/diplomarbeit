import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_nav_bar/screens/home/Screens_Home/all_tasks.dart';

class HomeSmaller350 extends StatefulWidget {
  const HomeSmaller350({Key? key, required this.constraint}) : super(key: key);

  final constraint;

  @override
  _HomeSmaller350State createState() => _HomeSmaller350State();
}

class _HomeSmaller350State extends State<HomeSmaller350> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final constraintX = widget.constraint;
    return Center(
      child: FittedBox(
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.of(context).size.height*1,
          width: MediaQuery.of(context).size.width*1,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20,top: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    constraintX.toString(),
                    style: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: 13
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20,left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Not finished',
                    style: theme.textTheme.headline5,
                  ),
                ),
              ),
              Flexible(
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
                                      "Rocomp-23-08-Server",
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 0, left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recently finished',
                    style: theme.textTheme.headline5,
                  ),
                ),
              ),
              Flexible(
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
                                      "LeDuigou-22-08-Kassa",
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 0, left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Activities',
                    style: theme.textTheme.headline5,
                  ),
                ),
              ),
              Flexible(
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
                                      "Max-Mustermann-22-08-Computer-Kauf",
                                      style: theme.textTheme.headline3,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconTheme(
                                  data: new IconThemeData(
                                      color: theme.shadowColor,
                                      size: 35
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_sharp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              Flexible(
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
                                      "Intern-22-08",
                                      style: theme.textTheme.headline3,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconTheme(
                                  data: new IconThemeData(
                                      color: theme.shadowColor,
                                      size: 35
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_sharp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              Flexible(
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
                                      "Häusle-20-08-Computer-Software",
                                      style: theme.textTheme.headline3,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconTheme(
                                  data: new IconThemeData(
                                      color: theme.shadowColor,
                                      size: 35
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_sharp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              Flexible(
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
                                      "Fulterer-19-08-Computer-Hardware",
                                      style: theme.textTheme.headline3,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconTheme(
                                  data: new IconThemeData(
                                      color: theme.shadowColor,
                                      size: 35
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_sharp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              Flexible(
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
                                      "Fulterer-19-08-Computer-Hardware",
                                      style: theme.textTheme.headline3,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconTheme(
                                  data: new IconThemeData(
                                      color: theme.shadowColor,
                                      size: 35
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_sharp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30,top: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*0.07,
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
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.shadowColor,
                                      fontSize: 22
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconTheme(
                              data: new IconThemeData(
                                  color: theme.shadowColor,
                                  size: 35
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
