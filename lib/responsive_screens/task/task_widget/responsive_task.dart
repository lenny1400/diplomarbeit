import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:simple_nav_bar/responsive_screens/task/tasks/existing_customer.dart';
import 'package:simple_nav_bar/responsive_screens/task/tasks/intern.dart';
import 'package:simple_nav_bar/responsive_screens/task/tasks/new_customer.dart';

class ResponsiveTask extends StatefulWidget {
  const ResponsiveTask({
    Key? key,
    required this.cons1,
    required this.cons2,
    required this.cons3,
    required this.cons4,
  }) : super(key: key);

  final cons1;
  final cons2;
  final cons3;
  final cons4;

  @override
  _ResponsiveTaskState createState() => _ResponsiveTaskState();
}

class _ResponsiveTaskState extends State<ResponsiveTask> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //Green Output to Screen for debugging purposes
    final mdHeight = MediaQuery.of(context).size.height;
    final mdWidth = MediaQuery.of(context).size.width;
    //constants
    final _cons1 = widget.cons1;
    final _cons2 = widget.cons2;
    final _cons3 = widget.cons3;
    final _cons4 = widget.cons4;

    return Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          child: Container(
            width: mdWidth,
            height: mdHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(top: _cons1,),
                      child: Text(
                        'ta_title1'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: _cons4,
                          fontWeight: FontWeight.w400,
                          color: theme.dividerColor
                        ),
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.2),
                  child: Container(
                    height: _cons4,
                    width: _cons3,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnIntern",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => InternPage(title: 'Intern',)));
                      },
                      child: Text(
                        'ta_buttonIntern'.tr,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _cons2),
                  child: Container(
                    height: _cons4,
                    width: _cons3,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnNewCustomer",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => NewCustomerPage(title: 'ta_appbar3'.tr,)));
                      },
                      child: Text(
                        'ta_buttonNewCustomer'.tr,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _cons2),
                  child: Container(
                    height: _cons4,
                    width: _cons3,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnExisitngCustomer",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        int pop = 1;
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ExistingCustomerPage(title: 'ta_appbar4'.tr,pop: pop,)));
                      },
                      child: Text(
                        'ta_buttonOldCustomer'.tr,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}