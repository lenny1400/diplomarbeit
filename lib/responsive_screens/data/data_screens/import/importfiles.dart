import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:simple_nav_bar/responsive_screens/data/data_screens/import/fromfiles.dart';

import '../../../../themes.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ImportFiles());
}

class ImportFiles extends StatefulWidget {
  const ImportFiles({Key? key}) : super(key: key);

  @override
  _ImportFilesState createState() => _ImportFilesState();
}

class _ImportFilesState extends State<ImportFiles> {

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
      home: ImportFilesPage(title: 'da_appbarImportFiles'.tr),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class ImportFilesPage extends StatefulWidget {
  const ImportFilesPage({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  _ImportFilesPageState createState() => _ImportFilesPageState();
}

class _ImportFilesPageState extends State<ImportFilesPage> {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.title,
          style: theme.textTheme.bodySmall,
        ),
        elevation: 0,
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height*0.07,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnImportFile",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        //int pop = 1;
                        //Navigator.push(context, MaterialPageRoute(builder: (_) => ExistingCustomerPage(title: 'Existing Customer',pop: pop,)));
                        Navigator.push(context, MaterialPageRoute(builder: (_) => FromFile()));
                      },
                      child: Text(
                        'da_device'.tr,
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height*0.07,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnImportDatabase",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('No Database connected'),
                            backgroundColor: theme.scaffoldBackgroundColor,
                          ),
                        );
                        //int pop = 1;
                        //Navigator.push(context, MaterialPageRoute(builder: (_) => ExistingCustomerPage(title: 'Existing Customer',pop: pop,)));
                      },
                      child: Text(
                        'da_database'.tr,
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

