import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/model/MovieListResponse.dart';
import 'package:flutter_movie_app/model/Result.dart';
import 'package:flutter_movie_app/utils/constants.dart';
import 'package:http/http.dart' as http;


import '../widget/movie_list_item.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<Dashboard> {
  ScrollController _scrollController = new ScrollController();
  TextEditingController editingController = TextEditingController();

  bool isLoading = false;
  int nextPage = 0;
  List<ResultItem> _resultList = new List();

  Future<List<ResultItem>> getMovieList() async {
    List<ResultItem> usersResponse;

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      nextPage++;
      String uri = AppUrls.GET_NOW_PLAYING +
          "?api_key=" +
          AppConstants.MOVIE_API_KEY +
          "&page=" +
          '$nextPage' +
          '&language=en-US';
      print(uri);

      var response =
          await http.get(Uri.encodeFull(uri), headers: AppConstants.headers);

      if (response.statusCode == 200) {
        if (response.body == null) return null;
        Map data = json.decode(response.body);
        MovieListResponse movieListResponse = MovieListResponse.fromJson(data);
        usersResponse = movieListResponse.resultList;

        setState(() {
          isLoading = false;
          _resultList.addAll(usersResponse);
        });
      } else {
        nextPage = 0;
        _resultList = new List();
      }
    }
    return usersResponse;
  }

  Future<List<ResultItem>> searchMovie(String query) async {
    List<ResultItem> usersResponse;

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      nextPage++;
      String uri = AppUrls.GET_SEARCH_MOVIE +
          "?api_key=" +
          AppConstants.MOVIE_API_KEY +
          "&query=" +
          query +
          "&page=" +
          '$nextPage' +
          '&language=en-US';
      print(uri);

      var response =
          await http.get(Uri.encodeFull(uri), headers: AppConstants.headers);

      print(response.body.toString());
      if (response.statusCode == 200) {
        if (response.body == null) return null;
        Map data = json.decode(response.body);
        MovieListResponse movieListResponse = MovieListResponse.fromJson(data);
        usersResponse = movieListResponse.resultList;

        setState(() {
          isLoading = false;
          _resultList.addAll(usersResponse);
        });
      } else {
        nextPage = 0;
        _resultList = new List();
      }
    }
    return usersResponse;
  }

  @override
  void initState() {
    getMovieList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (editingController.value.text.isEmpty)
          getMovieList();
        else
          searchMovie(editingController.value.text);
      }
    });
  }

  @override
  void dispose() {
    editingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _resultList.length,
        itemBuilder: (ctx, i) {
          if (i == _resultList.length - 1) {
            return _buildProgressIndicator();
          } else {
            return MovieListItem(_resultList[i]);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  if (value.isEmpty) {
                    getMovieList();
                  } else {
                    setState(() {
                      _resultList.clear();
                      nextPage = 0;
                      searchMovie(value);
                    });
                  }
                },
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _resultList.clear();
                      nextPage = 0;
                      getMovieList();
                    });
                  }
                },
                controller: editingController,
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          editingController.value.text.isEmpty ?
                          'Now Playing': 'Search results for \'${editingController.value.text}\'',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Flex(direction: Axis.vertical, children: <Widget>[
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _buildList(),
                        ),
                      ),
                    ]),
//            SizedBox(
//              height: 30,
//            ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
