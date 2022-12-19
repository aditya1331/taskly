import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  String? _newTaskContent;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    print("Input value $_newTaskContent");


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.2*deviceHeight,
        title: Text("Taskly!",style: TextStyle(
          fontSize: 20,
        ),),

      ),
      body: _taskList() ,
      floatingActionButton: _addTask(),
    );
  }

Widget _taskList()
{
  return ListView(
    children:  [
      ListTile (
        title: const Text("Do Laundry!",
            style: TextStyle(
                decoration: TextDecoration.lineThrough)
        ),
        trailing: const Icon(Icons.check_box_outlined,
        color: Colors.red,),
        subtitle: Text(DateTime.now().toString()),
      )
    ],
  );
}

Widget _addTask()
{
  return FloatingActionButton(
    onPressed: _displayTaskPopup,
    child: const Icon(Icons.add,),

  );

}

void _displayTaskPopup()
{
  showDialog(context: context,builder: (BuildContext _context)
  {
    return AlertDialog(
        title: const Text("Add new Task"),
        content: TextField(
        onSubmitted: (_value){},
        onChanged: (_value){
          setState(() {
            _newTaskContent = _value;
          });// This function calls the build function indicating the state has been changed
        },
      ),
    );
  },
  );

}
}