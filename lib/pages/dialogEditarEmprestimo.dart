import 'package:cobrador/logica/emprestimo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../logica/emprestimosDAO.dart';

class dialogEditarEmprestimo extends StatefulWidget {
  @override
  _dialogEditarEmprestimoState createState() =>
      _dialogEditarEmprestimoState();

  Function() refreshLista;
  Emprestimo emprestimo;
  dialogEditarEmprestimo({Key key, this.refreshLista, this.emprestimo})
      : super(key: key);
}

class _dialogEditarEmprestimoState extends State<dialogEditarEmprestimo> {
  final dbEmp = emprestimosDAO.instance;

  int idEmprestimo;

  // DateTime dataInicial;
  DateTime dataEscolhida;

  TextEditingController customControllerNome = TextEditingController();
  TextEditingController customControllerValor = TextEditingController();
  TextEditingController customControllerData = TextEditingController();
  TextEditingController customControllerNota = TextEditingController();

  @override
  void initState() {
    super.initState();
    idEmprestimo = widget.emprestimo.id;
    customControllerNome.text = widget.emprestimo.nomePessoa;
    customControllerValor.text = widget.emprestimo.valor.toStringAsFixed(2);
    customControllerData.text = widget.emprestimo.data.toString();
    customControllerNota.text = widget.emprestimo.nota;
    dataEscolhida = widget.emprestimo.data;
  }

  _escolherData() async {
    DateTime data = await showDatePicker(
        context: context,
        initialDate: dataEscolhida,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (data != null) {
      setState(() {
        dataEscolhida = data;
      });
    }
  }

  void atualizarEmprestimo(int id, String nomePessoa, double valor,String data,String nota) async {
    // linha para atualizar
    Map<String, dynamic> row = {
      emprestimosDAO.columnId : id,
      emprestimosDAO.columnNomePessoa : nomePessoa,
      emprestimosDAO.columnValor  : valor,
      emprestimosDAO.columnData : data,
      emprestimosDAO.columnNota : nota,
    };
    final linhasAfetadas = await dbEmp.update(row);
    print('atualizadas $linhasAfetadas linha(s)');
  }




  String checkProblemas(){
    String erros = "";
    if (customControllerNome.text.isEmpty) {
      erros += "Insira um nome\n";
    }
    if (customControllerValor.text.isEmpty) {
      erros += "Insira um valor\n";
    }
    return erros;
  }

  showAlertDialogErros(BuildContext context) {

    Widget okButton = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: Text(
        "Erro",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        checkProblemas(),
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    customControllerData.text =
        DateFormat("dd/MM/yyyy").format(dataEscolhida).toString();

    return Scaffold(
      //resizeToAvoidBottomInset:false,
      appBar: AppBar(title: Text('Editar Empréstimo'),

        actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {

              if (checkProblemas().isEmpty) {
                atualizarEmprestimo(
                    idEmprestimo,
                    customControllerNome.text,
                    double.parse(customControllerValor.text),
                    customControllerData.text,
                    customControllerNota.text
                );
                widget.refreshLista();
                Navigator.of(context).pop();
              } else {
                showAlertDialogErros(context);
              }

            },
            child: Icon(
              Icons.save_outlined,
              size: 26.0,
            ),
          ),
        )
      ]),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15,
              ),

              TextField(
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: customControllerNome,
                maxLength: 30,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_rounded),
                    hintText: "Nome",
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(8.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(8.0))),
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              SizedBox(
                height: 10,
              ),

              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: customControllerValor,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.monetization_on_outlined),
                    hintText: "Valor",
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(8.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(8.0))),
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              SizedBox(
                height: 32,
              ),

              TextField(
                onTap: _escolherData,
                readOnly: true,
                //SOMENTA PARA DATA
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: customControllerData,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range_outlined),
                    hintText: "Data",
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(8.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(8.0))),
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              SizedBox(
                height: 32,
              ),

              TextField(
                minLines: 1,
                maxLines: 2,
                maxLength: 50,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: customControllerNota,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.text_snippet_outlined),
                    hintText: "Nota",
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(8.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(8.0))),
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
