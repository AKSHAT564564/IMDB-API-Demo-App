import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:imdb_api/pages/movie_card.dart';

class SerachPage extends StatefulWidget {
  const SerachPage({Key? key}) : super(key: key);

  @override
  _SerachPageState createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  bool _searchRequest = false, _isLoading = false;
  String searchFeildValue = "";
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget customSearchBar = const Text('IMDB API Demo');
  List<Map<String, dynamic>> searchDetails = [];

  TextEditingController searchFeildController = TextEditingController();

  Future getResponse(String query) async {
    var responseData = await http.get(
        Uri.parse(
            'https://imdb-internet-movie-database-unofficial.p.rapidapi.com/search/$query'),
        headers: {
          "x-rapidapi-key":
              "0f6420ad4fmsh536b6db4100a338p1d6e59jsnca0fa78483f6",
          "x-rapidapi-host":
              "imdb-internet-movie-database-unofficial.p.rapidapi.com",
        });

    setState(() {
      Map dataMap = jsonDecode(responseData.body);
      if (searchDetails.isNotEmpty) searchDetails = [];
      for (var i in dataMap["titles"]) {
        searchDetails.add(i);
      }
      print(searchDetails);

      _isLoading = false;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = ListTile(
                      leading: IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 16,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          setState(() {
                            _searchRequest = true;
                            _isLoading = true;
                          });
                          await getResponse(searchFeildController.text);
                        },
                      ),
                      title: TextFormField(
                        controller: searchFeildController,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'please Enter';
                          else
                            return null;
                        },
                        onChanged: (value) {
                          searchFeildValue = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search Movie/Series...',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('IMDB API Demo');
                  }
                });
              },
              icon: customIcon)
        ],
        centerTitle: true,
      ),
      body: _searchRequest == false
          ? const Center(
              child: Text(
                'Search For Your Fav Movie or Web Series',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: searchDetails.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                        id: searchDetails[index]["id"],
                        imageUrl: searchDetails[index]["image"],
                        title: searchDetails[index]["title"]);
                  }),
    );
  }
}
