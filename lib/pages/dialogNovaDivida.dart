import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../logica/dividasDAO.dart';

class dialogNovaDivida extends StatefulWidget {
  @override
  _dialogNovaDividaState createState() => _dialogNovaDividaState();

  Function() refreshLista;
  dialogNovaDivida({Key key, this.refreshLista}) : super(key: key);
}

class _dialogNovaDividaState extends State<dialogNovaDivida> {
  final dbDividas = dividasDAO.instance;

  // DateTime dataInicial;
  DateTime dataEscolhida;

  @override
  void initState() {
    super.initState();
    dataEscolhida = DateTime.now();
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

  void _salvarDivida(String nomePessoa,double valor,
      String data,String nota) async {
    final dbDividas = dividasDAO.instance;
    Map<String, dynamic> row = {

      dividasDAO.columnNomePessoa : nomePessoa,
      dividasDAO.columnValor  : valor,
      dividasDAO.columnData : data,
      dividasDAO.columnNota : nota,

    };
    final id = await dbDividas.insert(row);
  }

  TextEditingController customControllerNome = TextEditingController();
  TextEditingController customControllerValor = TextEditingController();
  TextEditingController customControllerData = TextEditingController();
  TextEditingController customControllerNota = TextEditingController();

  String checkProblemas(){
    String erros = "";
    if (customControllerNome.text.isEmpty) {
      erros += "Insira um nome\n";
    }
    if (customControllerValor.text.isEmpty) {
      erros += "Insira um valor\n";
    }
    if (customControllerNome.text.length > 30) {
      erros += "Nome muito extenso\n";
    }
    if (customControllerNota.text.length > 50) {
      erros += "Nota muito extensa";
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
      appBar: AppBar(title: Text('Nova Dívida'),

          actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: ()  {
              if (checkProblemas().isEmpty) {
                _salvarDivida(
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
                maxLength: 30,
                maxLengthEnforced: true,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: customControllerNome,
                autofocus: true,
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
                //(RegExp(r'^(\d+)?\.?\d{0,2}')) = SÓ O PONTO SEM VIRGULA
                //(RegExp(r'^(\d+)?\.?\,?\d{0,2}')) = AMBOS
                //(RegExp(r'^(\d+)?\,?\d{0,2}')) = SÓ VIRGULA
                autofocus: true,
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
                maxLength: 50,
                maxLengthEnforced: true,
                minLines: 1,
                maxLines: 2,
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
