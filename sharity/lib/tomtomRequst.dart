import 'package:http/http.dart' as http;

Future<http.Response> fetchAlbum(String url) async {
  final response = await http.get(url);
  //final response = await http.get('https://api.tomtom.com/map/1/staticimage');
}

class Album {
  final String layer;
  final String style;
  final String format;
  final int width;
  final int height;
  final String view;
  final String key;

  final String lon;
  final String lat;
  final int zoom;

  Album({this.layer, this.style, this.format,
         this.width, this.height, this.view,
         this.lon, this.key, this.lat, this.zoom});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      layer: 'basic',
      style: 'main',
      format: 'png',
      width: 256,
      height: 256,
      view: 'Unified',
      key: 'yirJiURqW2kiZQ1hNQJ1UIcS2IC7MfPm',
      lon: json['lon'],
      lat: json['lat'],
      zoom: json['zoom']
    );
  }
}