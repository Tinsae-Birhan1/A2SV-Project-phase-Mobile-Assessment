import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mobile_assesment/weathers/domain/entity/favorite.dart';
import 'package:mobile_assesment/weathers/domain/entity/weather.dart';
import 'package:mobile_assesment/weathers/presentation/bloc/weather_event.dart';

import '../bloc/weather_bloc.dart';

class WeatherDetail extends StatefulWidget {
  final Weather? weather;
  const WeatherDetail({super.key, this.weather});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  void dispatchFavorite() {
    context.read<WeatherBloc>().add(FavoriteEvent(
        favorite: Favorite(
            query: widget.weather!.query,
            temperatureC: widget.weather!.temperatureC,
            weatherIconUrl: widget.weather!.weatherIconUrl)));
  }

  @override
  Widget build(BuildContext context) {
    final now = DateFormat("dd-MMM-yyyy").format(DateTime.now());
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/Rectangle.png'))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.weather!.query,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF211772),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        now,
                      ),
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.favorite_border_outlined),
                    onPressed: dispatchFavorite)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: SizedBox(
                    width: 250,
                    height: 250,
                    child: Image.network(
                      widget.weather!.weatherIconUrl,
                      fit: BoxFit.cover,
                    ))),
            // SvgPicture.asset('images/mostly_sunny copy.svg',
            //     width: 250, height: 250, semanticsLabel: 'Acme Logo'),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Mostly Sunny',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFF9F93FF)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '${widget.weather!.temperatureC}\u00B0',
                style: TextStyle(
                    color: Color(0xFF211772),
                    fontSize: 72,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (_, index) {
                          final datel = DateTime.parse(
                                  widget.weather!.dailyWeather[index].date)
                              .toLocal();
                          final ans = DateFormat("dd-MMM-yyyy").format(datel);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ans.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${widget.weather!.dailyWeather[index].maxTempC}\u00B0',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${widget.weather!.dailyWeather[index].minTempC}\u00B0',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                        height: 30,
                                        child: Image.network(
                                            widget.weather!.weatherIconUrl)),
                                  ],
                                ),
                              ),
                            ],
                          );
                        })),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Color(0xFF211772),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
