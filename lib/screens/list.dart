//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/dblivros.dart';
import 'package:appcrudsqlite/screens/edit.dart';

class ListLivro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListLivro();
  }
}

class _ListLivro extends State<ListLivro> {
  List<Map> slist = [];

  DbLivros mydb = DbLivros();

  @override
  void initState() {
    mydb.open();

    getdata();

    super.initState();
  }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      //use delay min 500 ms, because database takes time to initilize.

      slist = await mydb.db.rawQuery('SELECT * FROM livro');

      setState(() {}); //refresh UI after getting data from table.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Livros Cadastrados"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.length == 0
              ? Text("Carregando Livros")
              : //show message if there is no any student

              Column(
                  //or populate list to Column children if there is student data.

                  children: slist.map((stuone) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text(stuone["nome"]),
                        subtitle: Text("Código:" +
                            stuone["roll_no"].toString() +
                            ", Preço: " +
                            stuone["preco"]),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  //  Navigator.push(context, MaterialPageRoute(
                                  //    builder: (BuildContext context) {
                                  //   return EditBook(rollno: stuone["roll_no"]);
                                  //   })); //navigate to edit page, pass student roll no to edit
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await mydb.db.rawDelete(
                                      "DELETE FROM livro WHERE roll_no = ?",
                                      [stuone["roll_no"]]);

                                  //delete student data with roll no.

                                  print("Data Deleted");

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Livro Apagado!")));

                                  getdata();
                                },
                                icon: Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
