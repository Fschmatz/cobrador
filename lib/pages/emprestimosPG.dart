import 'package:cobrador/logica/emprestimo.dart';
import 'package:cobrador/pages/dialogEditarEmprestimo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../logica/emprestimosDAO.dart';
import 'dialogNovoEmprestimo.dart';

class EmprestimosPG extends StatefulWidget {
  @override
  _EmprestimosPGState createState() => _EmprestimosPGState();

  EmprestimosPG({Key key}) : super(key: key);
}

class _EmprestimosPGState extends State<EmprestimosPG> {
  //LOGICA DB
  List<Map<String, dynamic>> listaEmprestimos = new List();
  final dbEmprestimos = emprestimosDAO.instance;

  @override
  void initState() {
    super.initState();
    getAllEmprestimos();
  }

  Future<void> getAllEmprestimos() async {
    var resposta = await dbEmprestimos.queryAllRows();
    setState(() {
      listaEmprestimos = resposta;
    });
  }

  void _deletar(int id) async {
    final dbEmprestimos = emprestimosDAO.instance;
    final linhaDeletada = await dbEmprestimos.delete(id);
    print('Deletado $id');
  }

  //REFRESH PARA ATUALIZAR A LISTA
  Future refresh() {
    setState(() {
      getAllEmprestimos();
    });
  }

  //BOTTOM MENU  //Emprestimo emprestimoModal
  void bottomMenu(context, int id, String nomePessoaModal, double valorModal,
      String dataModal, String notaModal) {
    Emprestimo emprestimoEditar = new Emprestimo(
        id: id,
        nomePessoa: nomePessoaModal,
        valor: valorModal,
        data: new DateFormat("dd/MM/yyyy").parse(dataModal),
        nota: notaModal);

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(

            //AJEITA TAMANHO CONFORME SE HOUVER TEM NOTA
            height: notaModal.isNotEmpty
                ? MediaQuery.of(context).size.height * 0.47
                : MediaQuery.of(context).size.height * 0.39,

            child: Wrap(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          leading: Icon(Icons.person_rounded),
                          title: Text(
                            nomePessoaModal,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        dialogEditarEmprestimo(
                                      emprestimo: emprestimoEditar,
                                      refreshLista: refresh,
                                    ),
                                    fullscreenDialog: true,
                                  ));
                            },
                            icon: Icon(Icons.edit_outlined),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        ListTile(
                          leading: Icon(Icons.monetization_on_outlined),
                          title: Text(
                            valorModal.toStringAsFixed(2),
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.date_range_outlined),
                          title: Text(
                            dataModal,
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        Visibility(
                          visible: notaModal.isNotEmpty,
                          child: ListTile(
                            leading: Icon(Icons.text_snippet_outlined),
                            title: Text(
                              notaModal,
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.5,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                          child: RaisedButton(
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            onPressed: () {
                              _deletar(id);
                              getAllEmprestimos();
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text(
                                "Pagar",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ])
                    ]),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //ITENS
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                itemCount: listaEmprestimos.length,

                itemBuilder: (context, int index) {
                  return Card(
                    elevation: 3.0,
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: InkWell(
                      onTap: () {
                        bottomMenu(
                          context,
                          listaEmprestimos[index]['_id'],
                          listaEmprestimos[index]['nomePessoa'],
                          listaEmprestimos[index]['valor'],
                          listaEmprestimos[index]['data'],
                          listaEmprestimos[index]['nota'],
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.person_rounded),
                                  title: Text(
                                    listaEmprestimos[index]['nomePessoa'],
                                    style: TextStyle(fontSize: 19),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.monetization_on_outlined),
                                  title: Text(
                                    listaEmprestimos[index]['valor']
                                        .toStringAsFixed(2),
                                    style: TextStyle(fontSize: 19),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        elevation: 1.0,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => dialogNovoEmprestimo(
                  refreshLista: refresh,
                ),
                fullscreenDialog: true,
              ));
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
