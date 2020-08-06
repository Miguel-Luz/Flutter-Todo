import 'package:todo/database.dart';
import 'package:todo/todo.dart';

class TodoRepository{
 
  final _db = Db();

  Future<bool> newTodo(Todo obj) async {
   var handleDb = await _db.getDb(); 
   var rows = await handleDb.insert('todo', obj.toMap());
    return rows > 0 ;
  }

  Future<bool> updateTodo(Todo obj) async {
  var handleDb = await _db.getDb(); 
  var  flag = obj.toMap();
  var rows = await handleDb.update('todo', {'done':flag['done']},where: 'id = ?',whereArgs: [obj.id]);
    return rows > 0 ;
  }

  Future<bool> delTodo(Todo obj) async {
   var handleDb = await _db.getDb(); 
   var rows = await handleDb.delete('todo', where: 'id = ?',whereArgs: [obj.id]);
    return rows > 0 ;
  }

  Future<List<Todo>> allTodo() async {
   var retorno = <Todo>[];
   var handleDb = await _db.getDb(); 
   var rows = await handleDb.query('todo');
         
    if(rows.isNotEmpty){
       rows.forEach((element) => retorno.add(Todo.fromMap(element))) ;
       return  retorno;
     }
      return  retorno;
   }
}