import 'package:flutter/material.dart';
import 'package:todo/todo.dart';
import 'package:todo/todo_repositorio.dart';
import 'model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

var _todoRepository = TodoRepository(); 
var _form = GlobalKey<FormState>();
final tarefaController = TextEditingController();
String _newTask;

List<Todo> _allTasks = [];
  
  void setListTask() async{
     _allTasks = await _todoRepository.allTodo();
      setState((){});
   }
  
void addTask(String desc) async{
   await _todoRepository.newTodo(Todo(description: desc));
      setState((){});
   }

 void deleteTask(Todo task) async{
     await _todoRepository.delTodo(task);
     setListTask();
  }

  void updateTask(Todo task) async {
    await _todoRepository.updateTodo(task);
    //setState(() {});
  }
   
  void _onSaved(){
  if(_form.currentState.validate()){
     _form.currentState.save();
     addTask(_newTask);
     setListTask();
   }
 }

@override
void initState() {
 super.initState();
 setListTask();
}

Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 3.0, right: 3.0),
        child: Column(
          children: <Widget>[
           Row(children: <Widget>[
             Expanded(
               flex: 2,
              child: 
              Form(
                key:_form,
                child: TextFormField(
                controller: tarefaController,  
                decoration: new InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),),
                labelText: 'Tarefa'
                 ),
                 onSaved:(value) => _newTask = value,
                 validator:(value) => (value.trim().length < 3) ? '3 caratcteres ao menos por favor!': null,
                  ),
                ),
               ),
               SizedBox(width: 10,),        
             RaisedButton.icon(
             onPressed:() {
              _onSaved();
              _form.currentState.reset();
             },
             icon: Icon(Icons.add), 
             label: Text('Adicionar'),
             ),
           ],),
            Expanded(
             child: ListView.builder(
              itemCount: _allTasks.length,
              itemBuilder: (context, index){
                      return ListTile(
                        title:CheckboxWidget(item: _allTasks[index],func: updateTask),
                        onLongPress: () => deleteTask(_allTasks[index]),
                      );
                    },
                   ),
                ),
             ],
        ),
      ),
    );
  }
}