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
      return '🌩️';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷️‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦️ time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕️';
    } else if (temp < 10) {
      return 'You\'ll need 🧣️ and 🧤️️';
    } else {
      return 'Bring a 🧥️️ just in case';
    }
  }
}
