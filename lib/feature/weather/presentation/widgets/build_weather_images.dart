class WeatherImages {
  static const String _path = 'assets/images';

  getWeatherImage(String weatherType) {
    print(weatherType);
    switch (weatherType) {
      case "clear sky":
        return '$_path/sunset.png';
      case "few clouds":
        return '$_path/cloud.png';
      case "scattered clouds":
        return '$_path/cloud.png';
      case "broken clouds":
        return '$_path/cloud.png';
      case "shower rain":
        return '$_path/rainfall.png';
      case "rain":
        return '$_path/rainfall.png';
      case "thunderstorm":
        return '$_path/lighting.png';
      case "snow":
        return '$_path/snow.png';
      case "mist":
        return '$_path/heavy_cloud.png';
      default:
        return '$_path/normal.png';
    }
  }
}
