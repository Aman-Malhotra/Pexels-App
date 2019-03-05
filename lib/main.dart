import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pexels/PexelsJSON.dart';

void main() {
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var url =
      "https://api.pexels.com/v1/search?query=wallpaper+query&per_page=15&page=1";
  Pexels pexels;
  Map<String, String> map = {
    "Authorization": "563492ad6f917000010000014b73d0044b1a48c9bc6fee394765f22a"
  };
  var decodedJson;
  Map<int, Response> resList = {};
  int pageNo = 0, page = 0;
  Client client;
  @override
  void initState() {
    super.initState();
    page++;
    client = new Client();
    fetchData(url, page);
  }

  fetchData(url, page) async {
    if (!resList.containsKey(page)) {
      print("Adding " + page.toString());
      pageNo++;
      client = new Client();
      resList.addAll({pageNo.toInt(): await client.get(url, headers: map)});
      client.close();
    }
    print("Fetching " + page.toString());
    resList.forEach((a, r) {
      if (a == page) {
        print("Page Found ");
        decodedJson = jsonDecode(r.body);
        pexels = Pexels.fromJson(decodedJson);
      } else {
        print("page not found");
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            page--;
            if (page > 1) {
              fetchData(pexels.nextPage, page);
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              page++;
              fetchData(pexels.nextPage, page++);
            },
          ),
        ],
      ),
      body: Center(
        child: (pexels != null)
            ? ListView.builder(
                itemCount: pexels.photos.length,
                itemBuilder: (c, index) {
                  Photo photo = pexels.photos[index];
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "By " + photo.photographer.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                            photo.src.large,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
