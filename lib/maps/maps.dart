import 'package:url_launcher/url_launcher.dart';

class MapsUtils {
  MapsUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query= $latitude,$longitude";

    if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);
    } else {
      throw "couldn't open map";
    }
  }

  static Future<void> openMapWithAddress(String fullAddress) async {
    String query = Uri.decodeComponent(fullAddress);
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query= $query";

     if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);
    } else {
      throw "couldn't open map";
    }
  }
}
