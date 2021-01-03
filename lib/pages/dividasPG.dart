import 'package:cobrador/logica/divida.dart';
import 'package:cobrador/logica/emprestimo.dart';
import 'package:cobrador/pages/dialogEditarEmprestimo.dart';
import 'package:cobrador/pages/dialogEditarDivida.dart';
import 'package:cobrador/pages/dialogNovaDivida.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../logica/dividasDAO.dart';

class DividasPG extends StatefulWidget {
  @override
  _DividasPGState createState() => _DividasPGState();

  DividasPG({Key key}) : super(key: key);
}

class _DividasPGState extends State<DividasPG> {
  //LOGICA DB
  List<Map<String, dynamic>> listaDividas = new List();
  final dbDividas = dividasDAO.instance;

  @override
  void initState() {
    super.initState();
    getAllDividas();
  }

  Future<void> getAllDividas() async {
    var resposta = await dbDividas.queryAllRows();
    setState(() {
      listaDividas = resposta;
    });
  }

  void _deletar(int id) async {
    final dbDiv = dividasDAO.instance;
    final linhaDeletada = await dbDiv.delete(id);
    print('Deletado $id');
  }

  //REFRESH PARA ATUALIZAR A LISTA
  Future refresh() {
    setState(() {
      getAllDividas();
    });
  }

  //BOTTOM MENU
  void bottomMenu(context, int id, String nomePessoaModal, double valorModal,
      String dataModal, String notaModal) {
    Divida dividaEditar = new Divida(
        id: id,
        nomePessoa: nomePessoaModal,
        valor: valorModal,
        data: new DateFormat("dd/MM/yyyy").parse(dataModal),
        nota: notaModal);

    showModalBottomSheet(
        //backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            //height: MediaQuery.of(context).size.height * 0.47,

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
                                        dialogEditarDivida(
                                      divida: dividaEditar,
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
                              getAllDividas();
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
                //SizedBox(height: 30,),
              ],
            ),
          );
        });
  }

  //DIALOG ADD VALOR MANUAL DEVERA SER FEITO JUNTO COM O EDITAR

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //ITENS
            Expanded(
              child: ListView.builder(
                //shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                itemCount: listaDividas.length,
                itemBuilder: (context, int index) {
                  return Card(
                    elevation: 3.0,
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: InkWell(
                      onTap: () {
                        bottomMenu(
                          context,
                          listaDividas[index]['_id'],
                          listaDividas[index]['nomePessoa'],
                          listaDividas[index]['valor'],
                          listaDividas[index]['data'],
                          listaDividas[index]['nota'],
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
                                    listaDividas[index]['nomePessoa'],
                                    style: TextStyle(fontSize: 19),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.monetization_on_outlined),
                                  title: Text(
                                    listaDividas[index]['valor']
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
          //Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => dialogNovaDivida(
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
