import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: Text("Tutorial"),
          centerTitle: true,

        ),

        body: ListView(
            children: <Widget>[

              Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: Text( ''' 
1.Como adicionar um empréstimo?   
-> Aperte o Botão " + " na página "Empréstimos" 
    para adicionar.
   
2.Como adicionar uma dívida?      
-> Aperte o Botão " + " na página "Dívidas" 
    para adicionar.
   
3.Como remover um empréstimo?   
-> Toque sobre o item e na janela de detalhes
    aperte o botão "Pagar"
   
4.Como remover uma dívida?      
-> Toque sobre o item e na janela de detalhes
    aperte o botão "Pagar"
   
5.Como editar um empréstimo?   
-> Toque sobre o item, na janela de detalhes
    toque o ícone de "Editar"
   
6.Como editar uma dívida?      
-> Toque sobre o item, na janela de detalhes
    toque o ícone de "Editar"
          
      ''',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ]));

  }
}

