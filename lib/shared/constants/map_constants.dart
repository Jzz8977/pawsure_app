class MapCoordinate {
  const MapCoordinate({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

class TencentMapConfig {
  const TencentMapConfig._();

  static const String key = '';
  static const String referer = 'pawsure-weapp';
  static const MapCoordinate defaultCenter = MapCoordinate(
    latitude: 39.908823,
    longitude: 116.39747,
  );
  static const int defaultScale = 16;
  static const String searchRegion = '全国';
  static const int searchLimit = 20;
  static const List<String> suggestionTypes = [
    'houseNumber',
    'poi',
    'street',
    'landmark',
  ];
  static const String autocompleteStrategy = 'keyword';
  static const bool enableRegionLimit = false;
}

class MapLocationType {
  const MapLocationType._();

  static const String gcj02 = 'gcj02';
  static const String wgs84 = 'wgs84';
}

class MapRouteMode {
  const MapRouteMode._();

  static const String driving = 'driving';
  static const String walking = 'walking';
  static const String transit = 'transit';
}

class MapPolylineStyle {
  const MapPolylineStyle({
    required this.color,
    required this.width,
    required this.dottedLine,
    required this.arrowLine,
    required this.borderColor,
    required this.borderWidth,
  });

  final String color;
  final int width;
  final bool dottedLine;
  final bool arrowLine;
  final String borderColor;
  final int borderWidth;
}

class MapConstants {
  const MapConstants._();

  static const MapPolylineStyle defaultPolylineStyle = MapPolylineStyle(
    color: '#3CC51F',
    width: 6,
    dottedLine: false,
    arrowLine: true,
    borderColor: '#FFFFFF',
    borderWidth: 2,
  );
}
