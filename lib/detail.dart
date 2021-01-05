import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future<List> getKomen() async {
    final response =
        await http.get("http://10.0.2.2/WebDinamis/webservices/get_komen.php");
    return json.decode(response.body);
  }

  // Widget widgetFutureBuilder() {
  //   return FutureBuilder<List>(
  //     future: getKomen(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) print(snapshot.error);
  //       return snapshot.hasData
  //           ? new DetailKomen(
  //               list: snapshot.data, id: widget.list[widget.index]['id'])
  //           : new Center(
  //               child: new CircularProgressIndicator(),
  //             );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.yellow[800],
            title: new Text("${widget.list[widget.index]['judul']}")),
        body: Center(
          child: new Card(
            child: new ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                Image.memory(base64Decode(widget.list[widget.index]['gambar'])),
                new Container(
                    child: new Column(children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top: 5)),
                  new Padding(padding: const EdgeInsets.only(bottom: 10)),
                  new Text(widget.list[widget.index]['judul'],
                      textAlign: TextAlign.center,
                      style: new TextStyle(fontSize: 18)),
                  new Text("Penulis : ${widget.list[widget.index]['penulis']}",
                      style: new TextStyle(fontSize: 14)),
                  new Text("Dipost pada: ${widget.list[widget.index]['tgl']}",
                      style: new TextStyle(fontSize: 14)),
                ])),
                new Padding(padding: const EdgeInsets.only(top: 10)),
                new Container(
                  child: new Text(widget.list[widget.index]['isi'],
                      style: new TextStyle(fontSize: 12)),
                ),
                new Padding(padding: const EdgeInsets.only(bottom: 10)),
                new Text("KOMENTAR :"),
                new FutureBuilder<List>(
                  future: getKomen(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? new DetailKomen(
                            list: snapshot.data,
                            id: widget.list[widget.index]['id'])
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class DetailKomen extends StatelessWidget {
  final List list;
  final id;
  DetailKomen({this.list, this.id});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        if (list[i]['id'] == id) {
          return Container(
            //padding: const EdgeInsets.all(1),
            child: new Card(
              child: Container(
                child: new Container(
                  padding: const EdgeInsets.all(8),
                  child: new Text(list[i]['komentar'],
                      style: new TextStyle(fontSize: 12)),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
