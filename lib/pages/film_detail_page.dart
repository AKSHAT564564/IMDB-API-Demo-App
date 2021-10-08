import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  final String id;
  final String title;
  const MyHomePage({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imageUrl = "",
      title = "",
      cast = "",
      rating = "",
      plot = "",
      length = "",
      trailer = "";
  String year = "";
  List<Map> castMap = [];

  // static Future<List<DataModel>> getResponse() async {
  //   String q = "Game of thrones";
  //   var responseData = await http.get(
  //       Uri.parse('https://imdb8.p.rapidapi.com/auto-complete?q=$q'),
  //       headers: {
  //         "x-rapidapi-key":
  //             "0f6420ad4fmsh536b6db4100a338p1d6e59jsnca0fa78483f6",
  //         "x-rapidapi-host": "imdb8.p.rapidapi.com",
  //         "useQuerySnapshot": "true"
  //       });
  //   Map data = jsonDecode(responseData.body);

  //   List _temp = [];

  //   for (var i in data["q"]) {
  //     _temp.add(i["l"]);
  //   }

  //   return DataModel.dataFromSnapshot(_temp);
  // }

  // List<DataModel>? _data;

  // Future<void> getData() async {
  //   _data = await getResponse();
  //   print(_data);
  // }\

  List<Map<String, dynamic>> dataMap = [];

  getResponse() async {
    var responseData = await http.get(
        Uri.parse(
            'https://imdb-internet-movie-database-unofficial.p.rapidapi.com/film/${widget.id}'),
        headers: {
          "x-rapidapi-key":
              "0f6420ad4fmsh536b6db4100a338p1d6e59jsnca0fa78483f6",
          "x-rapidapi-host":
              "imdb-internet-movie-database-unofficial.p.rapidapi.com",
        });
    setState(() {
      Map dataMap = jsonDecode(responseData.body);
      print(dataMap);

      imageUrl = dataMap["poster"];
      year = dataMap["year"];
      title = dataMap["title"];
      rating = dataMap["rating"];
      length = dataMap["length"];
      plot = dataMap["plot"];
      trailer = dataMap["trailer"]["link"];

      for (var i in dataMap["cast"]) {
        castMap.add(i);
      }
    });
  }

  Widget getBanner() {
    if (imageUrl != '') {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
      );
    } else {
      return Text('Loading Image');
    }
  }

  Widget getYear() {
    if (year != '') {
      return Text(year);
    } else {
      return Text('Loading');
    }
  }

  Widget getTitle() {
    if (title != '') {
      return Text(title,
          style: const TextStyle(
              fontSize: 24.0,
              color: Colors.black,
              fontWeight: FontWeight.bold));
    } else {
      return const Text('Loading',
          style: TextStyle(
              fontSize: 24.0,
              color: Colors.black,
              fontWeight: FontWeight.bold));
    }
  }

  Widget getCast() {
    if (castMap.isNotEmpty) {
      return Text("${castMap[0]["actor"]} , ${castMap[1]["actor"]}",
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ));
    } else {
      return const Text("Loading Cast",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ));
    }
  }

  Widget getRating() {
    if (rating != '') {
      return Text(rating);
    } else {
      return const Text("Loading");
    }
  }

  Widget getLength() {
    if (length != '') {
      return Text(length);
    } else {
      return const Text("Loading");
    }
  }

  Widget getPlot() {
    if (plot != '') {
      return Text(plot);
    } else {
      return const Text("Loading Plot");
    }
  }

  String getTrailerLink() {
    if (trailer != '') {
      return trailer;
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      getResponse();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      child: getBanner()),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 1.8,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getTitle(),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 8.0, 8.0, 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        getYear(),
                                        getRating(),
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.access_time_outlined),
                                            getLength(),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Text("Plot",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  getPlot(),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  const Text("Cast",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  getCast(),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60.0,
                                    child: ElevatedButton(
                                      child: Text("Trailer"),
                                      onPressed: () async {
                                        String url = getTrailerLink();
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Not Possible';
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red, // background
                                        onPrimary: Colors.white, // foreground
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
