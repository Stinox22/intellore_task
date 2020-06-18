import 'dart:math';

class ResultItem {
    int id;
    String overview;
    String poster_path;
    String title;
    double vote_average;

    ResultItem({this.id, this.overview, this.poster_path, this.title,  this.vote_average});

    factory ResultItem.fromJson(Map<String, dynamic> json) {
        return ResultItem(
            id: json['id'] != null ? int.parse(json['id'].toString()) : Random().nextInt(10000),
            overview: json['overview'] != null ? json['overview'] : "",
            poster_path: json['poster_path'] != null ? json['poster_path'] : "",
            title: json['title'] != null ? json['title'] : "",
            vote_average: json['vote_average'] != null ? double.parse(json['vote_average'].toString()) : 0.0,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['overview'] = this.overview;
        data['poster_path'] = this.poster_path;
        data['title'] = this.title;
        data['vote_average'] = this.vote_average;
        return data;
    }
}