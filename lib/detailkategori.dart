import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './detail.dart';

class DetailKategori extends StatefulWidget {
  List list;
  int index;
  DetailKategori({this.index, this.list});
  @override
  _DetailKategoriState createState() => _DetailKategoriState();
}

class _DetailKategoriState extends State<DetailKategori> {
  Future<List> getDetailKategori() async {
    final response = await http
        .get("http://10.0.2.2/WebDinamis/webservices/get_detailkategori.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.yellow[800],
        title: new Text("${widget.list[widget.index]['namakategori']}"),
      ),
      body: new FutureBuilder<List>(
        future: getDetailKategori(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new DetailListKategori(
                  list: snapshot.data,
                  id: widget.list[widget.index]['idkategori'])
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class DetailListKategori extends StatelessWidget {
  final List list;
  final id;
  DetailListKategori({this.list, this.id});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        if (list[i]['idkategori'] == id) {
          return Container(
            padding: const EdgeInsets.all(1),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(
                        list: list,
                        index: i,
                      ))),
              child: new Card(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: new ListTile(
                    title: new Text(list[i]['judul']),
                    leading: Image.memory(base64Decode(list[i]['gambar']),
                        height: 120, width: 50),
                    subtitle: new Text(
                        "Penulis : ${list[i]['penulis']}\nDipost pada : ${list[i]['tgl']}"),
                  ),
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
