import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';

import '../../../../themes.dart';

class ExportConfig extends StatefulWidget {
  final String csvFile;
  const ExportConfig({Key? key, required this.csvFile}) : super(key: key);

  @override
  _ExportConfigState createState() => _ExportConfigState();
}

class _ExportConfigState extends State<ExportConfig> {

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      if (this.mounted) { // check whether the state object is in tree
        setState(() {
          // make changes here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExportOptions(),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class ExportOptions extends StatefulWidget {
  const ExportOptions({Key? key}) : super(key: key);

  @override
  _ExportOptionsState createState() => _ExportOptionsState();
}

class _ExportOptionsState extends State<ExportOptions> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinput2 = TextEditingController();
  bool firstState= false;
  Object? _value = 1;
  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    dateinput2.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
          title: Text("da_appbarOptions".tr,
            style: theme.textTheme.bodySmall,
          ),
          elevation: 0,
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'da_titleExport'.tr, style: TextStyle(color: theme.shadowColor,fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  style: TextStyle(
                    color: theme.shadowColor,
                  ),
                  controller: dateinput, //editing controller of this TextField
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusColor: theme.shadowColor,
                    hoverColor: theme.shadowColor,
                    fillColor: theme.shadowColor,
                    icon: Icon(Icons.calendar_today,color: theme.shadowColor,), //icon of text field
                    labelText: "da_EnterDate".tr,
                    labelStyle: TextStyle(color: theme.shadowColor,fontSize: 20), //label text of field
                  ),
                  readOnly: true,  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );

                    if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text = formattedDate; //set output date to TextField value.
                      });
                    }else{
                      print("da_ErrorDate".tr);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(
                    color: theme.shadowColor,
                  ),
                  controller: dateinput2, //editing controller of this TextField
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusColor: theme.shadowColor,
                    hoverColor: theme.shadowColor,
                    fillColor: theme.shadowColor,
                    icon: Icon(Icons.calendar_today,color: theme.shadowColor,), //icon of text field
                    labelText: "da_EnterDate".tr,
                    labelStyle: TextStyle(color: theme.shadowColor,fontSize: 20), //label text of field
                  ),
                  readOnly: true,  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );

                    if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput2.text = formattedDate; //set output date to TextField value.
                      });
                    }else{
                      print("da_ErrorDate".tr);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
/*            Container(
              padding: EdgeInsets.all(20.0),
              child: DropdownButton(
                  value: this._value,
                  style: TextStyle(color: Colors.white),
                  items: [
                    DropdownMenuItem(
                      child: Text("First Item"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Second Item"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                        child: Text("Third Item"),
                        value: 3
                    ),
                    DropdownMenuItem(
                        child: Text("Fourth Item"),
                        value: 4
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      this._value = value;
                    });
                  }),
              ),*/
                Transform.scale(scale: 1.3,
                  child: Checkbox(value: this.firstState, onChanged: (newValue){
                    setState(() {
                      this.firstState = newValue!;
                    });
                  }, checkColor: theme.primaryColor,activeColor: theme.shadowColor,fillColor: WidgetStateProperty.all(theme.shadowColor), ),),
              ],
            )
        ),
      ),
    );
  }
}