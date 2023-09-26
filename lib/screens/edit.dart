import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/dblivros.dart';

class EditarLivro extends StatefulWidget {
  int rollno;

  EditarLivro({required this.rollno});

  @override
  State<StatefulWidget> createState() {
    return _EditarLivro();
  }
}

class _EditarLivro extends State<EditarLivro> {
  TextEditingController nome = TextEditingController();

  TextEditingController autor = TextEditingController();

  TextEditingController genero = TextEditingController();

  TextEditingController preco = TextEditingController();

  TextEditingController rollno = TextEditingController();

  DbLivros mydb = new DbLivros();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getLivro(widget.rollno);

      if (data != null) {
        nome.text = data["nome"];

        autor.text = data["autor"];

        genero.text = data["genero"];

        preco.text = data["preco"];

        rollno.text = data["roll_no"].toString();

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Livro"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nome,
                decoration: InputDecoration(
                  hintText: "Título",
                ),
              ),
              TextField(
                controller: autor,
                decoration: InputDecoration(
                  hintText: "Autor",
                ),
              ),
              TextField(
                controller: genero,
                decoration: InputDecoration(
                  hintText: "Genero",
                ),
              ),
              TextField(
                controller: preco,
                decoration: InputDecoration(
                  hintText: "Preço",
                ),
              ),
              TextField(
                controller: rollno,
                decoration: InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE livro SET nome = ?, autor = ?, genero=?, preco=?, roll_no=?  WHERE roll_no = ?",
                        [
                          nome.text,
                          rollno.text,
                          autor.text,
                          genero.text,
                          preco.text,
                          widget.rollno
                        ]);

                    //update table with roll no.

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Livro Alterado!")));
                  },
                  child: Text("Alterar Livro")),
            ],
          ),
        ));
  }
}
