import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';



class SignatureApp extends StatefulWidget {

  const SignatureApp({Key? key, required this.pop}) : super(key: key);

  final int pop;

  @override
  _SignatureAppState createState() => _SignatureAppState(this.pop);
}

class _SignatureAppState extends State<SignatureApp> {

  int pop;
  _SignatureAppState(this.pop);

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => true,
    onDrawEnd: () => true,
  );



  @override
  void initState() {
    super.initState();
    _controller.addListener(() => true);
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            title: Text("Unterschrift:",  style: theme.textTheme.headline6,),
          ),
          body: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
              ),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  //SIGNATURE CANVAS
                  Center(child: Signature(
                    controller: _controller,
                    height: 500,
                    backgroundColor: Colors.white,
                  )),
                ],
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.grey,
                  heroTag: "retry",
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                  child: Icon(Icons.refresh),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20,right: 20),
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: "Save",
                  backgroundColor: Colors.grey,
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      final Uint8List? data =
                      await _controller.toPngBytes();

                      Image.memory(data!);

                      String name = "423432";//id vom Auftag maybe?

                      Directory? directory = await getApplicationDocumentsDirectory();
                      String path = directory.path;
                      print(path);

                      await Directory('$path/signatures').create(recursive: true);

                      File('$path/signatures/$name.png')
                          .writeAsBytesSync(data.buffer.asInt8List());

                      var count = 0;

                      FocusScope.of(context).unfocus();

                      Navigator.popUntil(context, (route) {return count++ == pop;});

                    }
                  },
                  child: Icon(Icons.save),
                ),
              ),
            ],
          ),
        );
  }
}