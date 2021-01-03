import 'package:flutter/material.dart';
import '../../util/versaoNomeChangelog.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: Text("Sobre"),
          centerTitle: true,
        ),

        body: Container(
          padding: EdgeInsets.fromLTRB(10,0,10,5),
          child: ListView(
              children: <Widget>[

                SizedBox(height: 20),
                Text(versaoNomeChangelog.nomeApp+" " + versaoNomeChangelog.versaoApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 25),

                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.teal,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avatar.jpg'),
                  ),
                ),

                Text( '''                     
                
MARTELADO E REFEITO DO ZERO: 
0.5 X POR ENQUANTO !!! 
( MELHORANDO !!! )       
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),


                Text( '''                     
                                
 Aplicativo criado utilizando 
o Flutter e a linguagem Dart,
usado para testes e aprendizado. 
 
 Este aplicativo um dia terá 
seu código disponibilizado 
gratuitamente no GitHub e 
talvez adicionado ao F-Droid. 
            
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    //fontWeight: FontWeight.bold
                  ),
                ),

                Text( '''      
                
                       
“Learning is the only thing the mind never exhausts, 
 never fears, and never regrets.” 
- Leonardo da Vinci                
            
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ]),
        )
    );

  }
}

