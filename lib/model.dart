
import 'package:flutter/material.dart';
import 'package:todo/todo.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({ Key key, this.item, this.func}) : super(key: key);

  final Todo item;
  final Function func;

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('${widget.item.description}'),
      value: (widget.item.done == 1) ? true : false,
      onChanged: (bool value){
       widget.item.done = (value == true) ? 1 : 0;
       widget.func(widget.item); 
       setState((){}); 
     }, 
    );
   }
  }