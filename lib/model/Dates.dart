class DatesData {
    String maximum;
    String minimum;

    DatesData({this.maximum, this.minimum});

    factory DatesData.fromJson(Map<String, dynamic> json) {
        return DatesData(
            maximum: json['maximum'], 
            minimum: json['minimum'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['maximum'] = this.maximum;
        data['minimum'] = this.minimum;
        return data;
    }
}