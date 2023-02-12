import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_tdd/feature/weather/presentation/riverpod/provider/weather_provider.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final weatherText = ref.watch(weatherNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Weather Screen'),
              const SizedBox(height: 20),
              Text(weatherText.maybeMap(
                orElse: () => '',
                loading: (l) => 'loading...',
                error: (e) => e.error.toString(),
                getWeather: (value) =>
                    value.weatherEntity.weather.first.description!,
              )),
              const SizedBox(height: 20),
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City Name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_textEditingController.text.isNotEmpty) {
                    ref
                        .watch(weatherNotifierProvider.notifier)
                        .getWeather(cityName: _textEditingController.text);
                  }
                },
                child: const Text('Get Weather'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
