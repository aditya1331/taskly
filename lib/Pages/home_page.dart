import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _home_page();


  }

}
class _home_page extends State<HomePage>{
  //_home_page();
  late double deviceHeight,deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.2*deviceHeight,
        title: Text("Taskly!",style: TextStyle(
          fontSize: 20,
        ),),
      )
    );
  }


}