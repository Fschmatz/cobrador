import 'package:cobrador/pages/dividasPG.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/versaoNomeChangelog.dart';
import 'configs.dart';
import 'emprestimosPG.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  Home({Key key, }) : super(key: key);
}

class _HomeState extends State<Home> {

  @override
  void initState(){
    super.initState();
  }

  int _currentIndex = 0;
  final tabs = [
    EmprestimosPG(),
    DividasPG(),
    Configs(),
  ];

  List<Widget> pageList = List<Widget>();


  @override
  Widget build(BuildContext context) {

    pageList.add(EmprestimosPG());
    pageList.add(DividasPG());
    pageList.add(Configs());

    return Scaffold(

        //TOPO
        appBar: AppBar(
            elevation: 4.0,
            title: Text(versaoNomeChangelog.nomeApp),
            centerTitle: true,
        ),

        body: IndexedStack(
          index: _currentIndex,
          children: pageList,
        ),

        //BOTTOMBAR
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: false,

          currentIndex: _currentIndex,
            elevation: 5.0,

          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },

            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_upward_outlined),
                label: 'Empréstimos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_downward_outlined),
                label: 'Dívidas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Configurações',
              ),

            ],
          ),
        );
  }
}



