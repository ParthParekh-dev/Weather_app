import 'location.dart';
import 'networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String city) async {
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=9522f5627059d5f340828d8c0c0b1e16&units=metric');
    NetworkHelper networkHelper = new NetworkHelper(url: url);

    var weatherData = await networkHelper.getJsonData();

    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    Location location = new Location();
    await location.getCurrentLocation();

    var url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=' +
        location.latitude.toString() +
        '&lon=' +
        location.longitude.toString() +
        '&appid=9522f5627059d5f340828d8c0c0b1e16&units=metric');

    NetworkHelper networkHelper = new NetworkHelper(url: url);

    var weatherData = await networkHelper.getJsonData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'đŠī¸';
    } else if (condition < 400) {
      return 'đ§ī¸';
    } else if (condition < 600) {
      return 'âī¸';
    } else if (condition < 700) {
      return 'âī¸';
    } else if (condition < 800) {
      return 'đĢī¸';
    } else if (condition == 800) {
      return 'âī¸';
    } else if (condition <= 804) {
      return 'âī¸';
    } else {
      return 'đ¤ˇī¸â';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s đĻī¸ time';
    } else if (temp > 20) {
      return 'Time for shorts and đī¸';
    } else if (temp < 10) {
      return 'You\'ll need đ§Ŗī¸ and đ§¤ī¸ī¸';
    } else {
      return 'Bring a đ§Ĩī¸ī¸ just in case';
    }
  }
}
