import 'dart:convert';

class AppConstants {
  static const String BASE_URL = 'https://api.themoviedb.org/3/';
  static const MOVIE_API_KEY = "823cf6895f3aed07116b722541791369";

  // HTTP
  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static const Map<String, String> headersMultipart = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static final encoding = Encoding.getByName('utf-8');
}

class AppUrls {
  static const String GET_NOW_PLAYING = AppConstants.BASE_URL + 'movie/now_playing';
  static const String GET_SEARCH_MOVIE = AppConstants.BASE_URL + 'search/movie';
//  https://api.themoviedb.org/3/movie/now_playing?api_key=823cf6895f3aed07116b722541791369&language=en-US&page=1
//  https://api.themoviedb.org/3/search/movie?api_key=823cf6895f3aed07116b722541791369&language=en-US&query=inters&page=1&include_adult=false
}