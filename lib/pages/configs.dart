import 'package:cobrador/util/theme.dart';
import 'package:flutter/material.dart';
import '../util/versaoNomeChangelog.dart';
import 'package:provider/provider.dart';
import 'configsPages/about.dart';
import 'configsPages/changelog.dart';

class Configs extends StatefulWidget {
  @override
  _ConfigsState createState() => _ConfigsState();

  Configs({Key key})
      : super(key: key);
}

class _ConfigsState extends State<Configs> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 3.0,
                margin: const EdgeInsets.all(2.0),
                color: Colors.deepOrangeAccent,
                child: ListTile(
                  title: Text(
                    "Flutter " +
                        versaoNomeChangelog.nomeApp +
                        " " +
                        versaoNomeChangelog.versaoApp,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Card(
                elevation: 3.0,
                margin: const EdgeInsets.all(0.5),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.text_snippet_outlined),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        "Sobre",
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  About(),
                              fullscreenDialog: true,
                            ));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.text_snippet_outlined),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        "Changelog",
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  Changelog(),
                              fullscreenDialog: true,
                            ));
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Opções: ",
                style: TextStyle(fontSize: 21),
              ),

              SizedBox(
                height: 15.0,
              ),

              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  "Tema Escuro",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => Switch(
                      activeColor: Colors.blue,
                      value: notifier.darkTheme,
                      onChanged: (value) {
                        notifier.toggleTheme();
                      }),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
