// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

List<HomeModel> homeModelFromJson(String str) => List<HomeModel>.from(json.decode(str).map((x) => HomeModel.fromJson(x)));

String homeModelToJson(List<HomeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeModel {
  HomeModel({
    this.elementType,
    required this.stylers,
    this.featureType,
  });

  String? elementType;
  List<Styler> stylers;
  String? featureType;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    elementType: json["elementType"],
    stylers: List<Styler>.from(json["stylers"].map((x) => Styler.fromJson(x))),
    featureType: json["featureType"],
  );

  Map<String, dynamic> toJson() => {
    "elementType": elementType,
    "stylers": List<dynamic>.from(stylers.map((x) => x.toJson())),
    "featureType": featureType,
  };
}

class Styler {
  Styler({
    this.color,
    this.visibility,
  });

  String? color;
  String? visibility;

  factory Styler.fromJson(Map<String, dynamic> json) => Styler(
    color: json["color"],
    visibility: json["visibility"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "visibility": visibility,
  };
}
