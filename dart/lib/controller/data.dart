import 'package:chuva_dart/model/paper.dart';
import 'package:chuva_dart/model/person.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


// TODO: Retornar um array com os itens dos jsons
class PaperList extends StatefulWidget{
  @override
  _PaperListState createState() => _PaperListState();
}

class _PaperListState extends State<PaperList> {
  @override
  void initState(){
    super.initState();
    _loadData();
  }  

  //future - async
  Future<void> _loadData() async {
    List<Paper> papers = Paper.Map((json) => Paper.fromJson(json));
  }
}