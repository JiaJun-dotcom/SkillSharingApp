import 'package:flutter/material.dart';

void main(
  runapp( MyApp() );
)

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
            appBar: AppBar(title: Text('Material App Demo')),
      ),
body: Center(child: Image.asset('images/img.png')),
    );
}

}
