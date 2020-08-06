
class Todo {
 
 int id;
 String description;
 int done;
 
 Todo(
   {
    this.id,
    this.description,
    this.done,
  }
 );

Todo.fromMap(Map<String,dynamic> obj){
     id = obj['id'];
     description = obj['description'];
     done = obj['done']; 
   }

Map <String,dynamic> toMap(){
   
   return {
        'id':id,
        'description':description,
        'done': done
      };
    }
   }