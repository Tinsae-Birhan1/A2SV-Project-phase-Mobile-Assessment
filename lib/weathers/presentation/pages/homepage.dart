import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_assesment/weathers/presentation/bloc/weather_bloc.dart';
import 'package:mobile_assesment/weathers/presentation/bloc/weather_event.dart';
import 'package:mobile_assesment/weathers/presentation/pages/weather_detail.dart';

import '../bloc/weather_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(InitializeFavoriteEvent());
  }

  void dispatchSignup() {
    context
        .read<WeatherBloc>()
        .add(WeatherEvent(search: _searchController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherConditonState &&
            state.status == AuthStatus.loading) {
          final snackBar = SnackBar(content: Text("searching ..."));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // return Center(child: CircularProgressIndicator());
        } else if (state is WeatherConditonState &&
            state.status == AuthStatus.loaded) {
          // return _buildWeatherList(state.weather);
          if (state.weather != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeatherDetail(
                          weather: state.weather,
                        )));
          }
        } else if (state is WeatherConditonState &&
            state.status == AuthStatus.error) {
          // return Text("faild to load");
          final snackBar = SnackBar(content: Text(state.errorMessage!));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          // return Text('Unknown state');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: Text(
                    'Choose a city',
                    style: TextStyle(
                        color: Color(0xFF211772),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              hintText: 'Search a new city ...'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_searchController.text.isNotEmpty) {
                          // Perform further actions with the valid input

                          dispatchSignup();
                        }
                      },
                      child: Container(
                        height: 35,
                        width: 90,
                        child: Center(
                          child: Text(
                            'Search',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFBA25),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is FavoriteState &&
                          state.status == AuthStatus.loading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is FavoriteState &&
                          state.status == AuthStatus.loaded) {
                        final result = state.favorite;
                        if (result == null) {
                          context
                              .read<WeatherBloc>()
                              .add(InitializeFavoriteEvent());

                          return Text("data");
                        }
                        // return _buildWeatherList(state.weather);
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Fav Cities',
                                style: TextStyle(
                                  color: Color(0xFF211772),
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CityCard(
                                title: result!.query,
                                temp: result.temperatureC,
                                imageUrl: result.weatherIconUrl,
                              ),
                            ],
                          ),
                        );
                      } else if (state == AuthStatus.error) {
                        return Text("faild to load");
                      } else {
                        return Text('Loading');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/Rectangle.png'))),
        ),
      ),
    );
  }
}

class CityCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String temp;

  const CityCard({
    required this.title,
    required this.imageUrl,
    required this.temp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 80,
      width: 380,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            children: [
              Text(
                '${temp}\u00B0',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF211772),
                    fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                'images/mostly_sunny copy.svg',
                semanticsLabel: 'Acme Logo',
                height: 50,
                width: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}
