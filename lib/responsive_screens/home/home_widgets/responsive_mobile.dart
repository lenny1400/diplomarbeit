import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_nav_bar/responsive_screens/home/all_tasks.dart';
import 'package:get/get.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({
    Key? key,
    required this.constraint,
    required this.cons1,
    required this.cons2,
    required this.cons3,
    required this.cons4,
    required this.cons5,
    required this.itemCount,
  }) : super(key: key);

  final constraint;
  final cons1;
  final cons2;
  final cons3;
  final cons4;
  final cons5;
  final itemCount;

  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  @override
  Widget build(BuildContext context) {
    //themeData
    final theme = Theme.of(context);
    // const main size constraint
    final constraintX = widget.constraint;
    //Green Output to Screen for debugging purposes
    final mdHeight = MediaQuery.of(context).size.height;
    final mdWidth = MediaQuery.of(context).size.width;
    //item count of finished contract;
    final _itemCount = widget.itemCount;
    //constants
    final _cons1 = widget.cons1;
    final _cons2 = widget.cons2;
    final _cons3 = widget.cons3;
    final _cons4 = widget.cons4;
    final _cons5 = widget.cons5;
    final _boxHeight = ((2*_cons1) +_cons4)*_itemCount;

    return Center(
      child: FittedBox(
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        child: SizedBox(
          height: constraintX,
          width: mdWidth,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: _cons2,top: _cons2),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    (constraintX.toString()).split(".")[0] + " : " + (mdHeight.toString()).split(".")[0] + "-"+ (mdWidth.toString()).split(".")[0],
                    style: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: _cons1
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _cons2,left: _cons4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ho_title1'.tr,
                    style: TextStyle(
                        color: theme.dividerColor,
                        fontSize: _cons3,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: _cons4, right: _cons4,top: _cons1,),
                child: SizedBox(
                  height: _cons4,
                  width: mdWidth,
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
                              padding: EdgeInsets.only(left: _cons1),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Adidas-12-08-Server",
                                  style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: _cons2,
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
                                "ho_buttonText1".tr,
                                style: TextStyle(
                                    color: theme.dividerColor,
                                    fontSize: _cons1
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
                padding: EdgeInsets.only(left: _cons3, right: _cons3,top: _cons1),
                child: SizedBox(
                  width: mdWidth,
                  height: _cons5,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: theme.backgroundColor,
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, '/alltasks');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: _cons2),
                                child: Text(
                                  "ho_subtitle1".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.dividerColor,
                                      fontSize: _cons2
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconTheme(
                              data: IconThemeData(
                                  color: theme.dividerColor,
                                  size: _cons3
                              ),
                              child: const Icon(Icons.keyboard_arrow_right_sharp),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: _cons4,top: _cons2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ho_title2'.tr,
                    style: TextStyle(
                        color: theme.dividerColor,
                        fontSize: _cons3,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: mdWidth,
                height: _boxHeight.toDouble(),
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: _itemCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: _cons4, right: _cons4,top: _cons1,bottom: _cons1),
                      child: SizedBox(
                        height: _cons4,
                        width: mdWidth,
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
                                    padding: EdgeInsets.only(left: _cons1),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Adidas-12-08-Server",
                                        style: TextStyle(
                                          color: theme.dividerColor,
                                          fontSize: _cons2,
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
                                      "ho_buttonText1".tr,
                                      style: TextStyle(
                                          color: theme.dividerColor,
                                          fontSize: _cons1
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
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: _cons3, right: _cons3,top: _cons1),
                child: SizedBox(
                  width: mdWidth,
                  height: _cons5,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: theme.backgroundColor,
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, '/alltasks');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: _cons2),
                                child: Text(
                                  "ho_subtitle1".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.dividerColor,
                                      fontSize: _cons2
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconTheme(
                              data: IconThemeData(
                                  color: theme.dividerColor,
                                  size: _cons3
                              ),
                              child: const Icon(Icons.keyboard_arrow_right_sharp),
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