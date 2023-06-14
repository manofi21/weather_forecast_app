import 'package:equatable/equatable.dart';

class GeocodingRequestModel extends Equatable {
  const GeocodingRequestModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory GeocodingRequestModel.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return GeocodingRequestModel(
      name: data['name'],
      lat: data['lat'],
      lon: data['lon'],
      country: data['country'],
    );
  }

  final String country;
  final double lat;
  final double lon;
  final String name;

  @override
  List<Object> get props => [name, lat, lon, country];

  @override
  String toString() {
    return 'GeocodingRequestModel(name: $name, lat: $lat, lon: $lon, country: $country)';
  }
}
