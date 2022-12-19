import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/Models/Task.dart';

class HomePage extends StatefulWidget{
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _home_page();


  }

}
class _home_page extends State<HomePage>{
  _home_page();
  late double deviceHeight,deviceWidth;
  String? _newTaskContent;
  Box? _box;
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
      body: _taskView() ,
      floatingActionButton: _addTask(),
    );
  }

Widget _taskView()
{

  return FutureBuilder(future: Hive.openBox('tasks'),builder:
      (BuildContext _context, AsyncSnapshot _snapshot )
  {
    if(_snapshot.connectionState==ConnectionState.done)
      { _box =_snapshot.data;
        return _taskList();

      }
    else
      {
        return const Center(child: CircularProgressIndicator());
      }
    /*
    iF the data is retried then list of task are viewed or else
    a loading indicator screen is showed

    */


  },);
}
Widget _taskList()
{
  List tasks = _box!.values.toList();// ! says that values obtained from database or not NULL
  return ListView.builder(itemCount: tasks.length,itemBuilder: (BuildContext _context ,int _index)
  {
    var task = Task.fromMap(tasks[_index]);
    return  ListTile (
      title:  Text(task.content,
          style:  TextStyle(
              decoration: task.done ? TextDecoration.lineThrough : null)
      ),
      trailing:  Icon(
        task.done ? Icons.check_box_outlined : Icons.check_box_outline_blank_outlined,
        color: Colors.red,),
      subtitle: Text(task.timestamp.toString()),
    );

  },);

  //_box?.add(_newTask.toMap()); // passing the value that is to be stored in data base
// The ? speicifies conditional statement that if _box is not NULL then only excute the command
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
        onSubmitted: (_value){
          if(_newTaskContent!=null)
            {
              var task = Task(content: _newTaskContent!, timestamp:DateTime.now(), done: false);
              _box!.add(task.toMap());
              setState(() {
                _newTaskContent=null;
              });
            }
        },
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