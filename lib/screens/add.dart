import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/dblivros.dart';

class AddBooks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddBooks();
  }
}

class _AddBooks extends State<AddBooks> {
  TextEditingController nome = TextEditingController();
  TextEditingController autor = TextEditingController();
  TextEditingController genero = TextEditingController();
  TextEditingController preco = TextEditingController();
  TextEditingController roll_no = TextEditingController();

  //test editing controllers for form

  DbLivros mydb = DbLivros(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inserir Livros"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nome,
                decoration: const InputDecoration(
                  hintText: "Título do Livro",
                ),
              ),
              TextField(
                controller: autor,
                decoration: const InputDecoration(
                  hintText: "Autor do Livro",
                ),
              ),
              TextField(
                controller: genero,
                decoration: const InputDecoration(
                  hintText: "Gênero do Livro",
                ),
              ),
              TextField(
                controller: preco,
                decoration: const InputDecoration(
                  hintText: "Preço(R\$)",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: const InputDecoration(
                  hintText: "Código",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO livro(nome, autor, genero, preco, roll_no) VALUES (?, ?, ?, ?, ?);",
                        [
                          nome.text,
                          autor.text,
                          genero.text,
                          preco.text,
                          roll_no.text
                        ]); //add student from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Livro Adicionado")));

                    nome.text = "";

                    autor.text = "";

                    genero.text = "";

                    preco.text = "";

                    roll_no.text = "";
                  },
                  child: Text("Salvar Livro")),
            ],
          ),
        ));
  }
}
