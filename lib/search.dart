import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './model.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Post> _list = [];
  List<Post> _search = [];
  bool loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response = await http
        .get("http://10.0.2.2/WebDinamis/webservices/get_detailkategori.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Post.fromJson(i));
          loading = false;
        }
      });
    }
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.judul.toLowerCase().contains(text)) {
        _search.add(f);
      }
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.yellow[800],
          title: new Text("Search"),
        ),
        body: Container(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.yellow[800],
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                        hintText: "Cari Cerita", border: InputBorder.none),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.clear();
                      onSearch('');
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ),
              ),
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: _search.length != 0 || controller.text.isNotEmpty
                        ? ListView.builder(
                            itemCount: _search.length,
                            itemBuilder: (context, i) {
                              final search = _search[i];
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                child: new Card(
                                    child: new ListTile(
                                  title: new Text(
                                    search.judul,
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: new Image.memory(
                                      base64Decode("${search.gambar}"),
                                      height: 120,
                                      width: 50),
                                  subtitle: new Text(
                                      "Oleh : ${search.penulis}\nKategori : ${search.namakategori} \nDipost pada: ${search.tgl}"),
                                  dense: true,
                                )),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: _list.length,
                            itemBuilder: (context, i) {
                              final a = _list[i];
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                child: new Card(
                                    child: new ListTile(
                                  title: new Text(
                                    a.judul,
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: new Image.memory(
                                      base64Decode("${a.gambar}"),
                                      height: 120,
                                      width: 50),
                                  subtitle: new Text(
                                      "Oleh : ${a.penulis}\nKategori : ${a.namakategori} \nDipost pada: ${a.tgl}"),
                                  dense: true,
                                )),
                              );
                            }))
          ]),
        ));
  }
}
