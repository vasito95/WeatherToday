class Weather{
  String description;

  Weather({this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json["description"],
    );
  }
}