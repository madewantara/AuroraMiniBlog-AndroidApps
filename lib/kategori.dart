import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import './detail.dart';
import './detailkategori.dart';

class Kategori extends StatefulWidget {
  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  Future<List> getKategori() async {
    final response = await http
        .get("http://10.0.2.2/WebDinamis/webservices/get_kategori.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.yellow[800],
        title: new Text("Kategori"),
      ),
      body: new FutureBuilder<List>(
        future: getKategori(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ListKategori(list: snapshot.data)
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListKategori extends StatelessWidget {
  final List list;
  ListKategori({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
            padding: const EdgeInsets.all(1),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailKategori(
                        list: list,
                        index: i,
                      ))),
              child: new Card(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: new ListTile(
                    title: new Text(list[i]['namakategori']),
                    leading: new Icon(Icons.category_rounded),
                    // Image.memory(base64Decode(list[i]['gambar']),
                    //   height: 120, width: 80),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
