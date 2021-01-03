class Divida{

  int id;
  String nomePessoa;
  double valor;
  DateTime data; // ou var?
  String nota;

  Divida({this.id, this.nomePessoa,this.valor,this.data,this.nota});

  int get getId{
    return id;
  }

  String get getNome{
    return nomePessoa;
  }

  double get getValor{
    return valor;
  }

  /*String get getData{
    return data;
  }*/

  String get getNota{
    return nota;
  }
}