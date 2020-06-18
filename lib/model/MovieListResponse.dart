import 'package:flutter_movie_app/model/Dates.dart';
import 'package:flutter_movie_app/model/Result.dart';

class MovieListResponse {
    DatesData dates;
    int page;
    List<ResultItem> resultList;
    int total_pages;
    int total_results;

    MovieListResponse({this.dates, this.page, this.resultList, this.total_pages, this.total_results});

    factory MovieListResponse.fromJson(Map<String, dynamic> json) {

        var response =  MovieListResponse(
            page: json['page'],
            resultList: json['results'] != null ? (json['results'] as List).map((i) => ResultItem.fromJson(i)).toList() : null,
            total_results: json['total_results'],
        );
        return response;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['page'] = this.page;
        data['total_pages'] = this.total_pages;
        data['total_results'] = this.total_results;
        if (this.dates != null) {
            data['dates'] = this.dates.toJson();
        }
        if (this.resultList != null) {
            data['results'] = this.resultList.map((v) => v.toJson()).toList();
        }
        return data;
    }
}