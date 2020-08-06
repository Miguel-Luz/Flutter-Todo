import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Db {

Database _db;
final int  _versao = 2 ;
final String _nomeDB = 'todo.db';

static Db _instancia = Db._interno();
factory Db()=> _instancia;
Db._interno();

Future<Database> getDb() async {

 if(_db == null){
                             
  var _directory = await getApplicationDocumentsDirectory();
  var _path = join(_directory.path,_nomeDB);

  _db = await openDatabase(_path,version: _versao,onCreate: _onCreate ); 
 
 }
   return _db;
}

Future<void> _onCreate(Database db, int version) async {
   await db.execute(
    '''
      create table todo (
      id integer primary key autoincrement,
      description text not null,
      done integer default 0 
     );

    '''
   );
  } 
 }