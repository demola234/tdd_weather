import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_tdd/feature/weather/presentation/riverpod/provider/weather_provider.dart';
import 'package:practice_tdd/feature/weather/presentation/widgets/build_weather_images.dart';
import 'package:practice_tdd/feature/weather/presentation/widgets/weather_textfield.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final WeatherImages weatherImages = WeatherImages();
  @override
  Widget build(BuildContext context) {
    final weather = ref.watch(weatherNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              WeatherTextField(
                hintText: 'Search City',
                controller: _textEditingController,
                suffixIcon: IconButton(
                    onPressed: () {
                      if (_textEditingController.text.isNotEmpty) {
                        ref
                            .watch(weatherNotifierProvider.notifier)
                            .getWeather(cityName: _textEditingController.text);
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(height: 40),
              SizedBox(
                  height: 150,
                  width: 150,
                  child: weather.maybeMap(
                      orElse: () => Image.asset('assets/images/normal.png'),
                      loading: (l) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                      error: (e) => const Center(
                            child: Text('Error'),
                          ),
                      getWeather: (value) => Image.asset(
                          weatherImages.getWeatherImage(value
                              .weatherEntity.weather.first.description!)))),
              const SizedBox(height: 20),
              Text(
                weather.maybeMap(
                    orElse: () => 'Location',
                    loading: (l) => 'Loading...',
                    error: (e) => 'Error',
                    getWeather: (value) =>
                        "${value.weatherEntity.name!}, ${value.weatherEntity.sys!.country!}"),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C2C2C)),
              ),
              const SizedBox(height: 20),
              Text(
                weather.maybeMap(
                  orElse: () => 'Temp°',
                  loading: (l) => 'Loading...',
                  error: (e) => 'Error',
                  getWeather: (value) => '${value.weatherEntity.main!.temp!}°',
                ),
                style: const TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C2C2C)),
              ),
              const SizedBox(height: 20),
              Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFDFCFC),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Humidity",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFC4C4C4))),
                        Text(
                          weather.maybeMap(
                            orElse: () => '-',
                            loading: (l) => '...',
                            error: (e) => 'Error',
                            getWeather: (value) =>
                                '${value.weatherEntity.main!.humidity}',
                          ),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF9A9A9A)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Feels Like",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFC4C4C4))),
                        Text(
                          weather.maybeMap(
                            orElse: () => '-',
                            loading: (l) => '...',
                            error: (e) => 'Error',
                            getWeather: (value) =>
                                '${value.weatherEntity.main!.feelsLike!}°',
                          ),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF9A9A9A)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Description",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFC4C4C4))),
                        Text(
                          weather.maybeMap(
                            orElse: () => '-',
                            loading: (l) => '...',
                            error: (e) => 'Error',
                            getWeather: (value) =>
                                '${value.weatherEntity.weather.first.description}',
                          ),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF9A9A9A)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
