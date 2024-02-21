import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/src/common/theme.dart';
import 'package:weather_app/src/shared/shared.dart';
import 'package:weather_app/src/weather/domain/domain.dart';
import 'package:weather_app/src/weather/presenter/bloc/weather_bloc.dart';

part '_widget/skeleton.dart';
part '_widget/search.dart';
part '_widget/bottom_information.dart';
part '_widget/card_item.dart';
part '_widget/bottom_navigation.dart';
part '_widget/alert_error.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<WeatherBloc>()
        ..add(
          const OnLoadByGPS(
            units: UnitsType.celsius,
          ),
        ),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is NoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'There is no internet connection at the moment. Please try again later.',
            ),
          ));
        }
      },
      builder: (context, state) => Scaffold(
        body: _Body(),
        bottomNavigationBar: _BottomNavigationWidget(state: state),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.gps_fixed),
          onPressed: () async {
            BlocProvider.of<WeatherBloc>(context).add(
              OnLoadByGPS(units: state.units),
            );
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is ShowLoading) {
          return SkeletonWidget(
            message: state.message,
          );
        }

        final isCelsius = (UnitsType.celsius == state.units);
        final symbol = isCelsius ? '°C' : '°F';

        return Padding(
          padding: const EdgeInsets.all(DsSpace.md).copyWith(bottom: 0),
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<WeatherBloc>(context).add(
                OnLoadByLatLonEvent(
                  lat: state.weather.lat,
                  lon: state.weather.lon,
                  units: state.units,
                ),
              );
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DsVerticalSpace.xxl,
                  SearchWidget(),
                  if (state is WeatherFailure) ...[
                    DsVerticalSpace.xs,
                    const _AlertError(),
                  ],
                  DsVerticalSpace.lg,
                  if (state.search.isNotEmpty) ...[
                    Text(
                      state.search,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: DsSpace.xxl,
                      ),
                    ),
                  ],
                  Text(
                    state.weather.timezone,
                    style: const TextStyle(
                      fontSize: DsSpace.lg,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  DsVerticalSpace.xs,
                  Text(
                    DateFormat.E().add_d().add_MMM().format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: DsSpace.md,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DsVerticalSpace.lg,
                  if (state.weather.current.weather.isNotEmpty) ...[
                    loadSvgIcon(
                      state.weather.current.weather.first.description,
                    )
                  ],
                  DsVerticalSpace.xl,
                  Center(
                    child: Text(
                      '${state.weather.current.temp.toInt()}$symbol',
                      style: TextStyle(
                        fontSize: DsSpace.xxl * 3,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  if (state.weather.current.weather.isNotEmpty) ...[
                    Center(
                      child: Text(
                        state.weather.current.weather.first.main,
                        style: const TextStyle(
                          fontSize: DsSpace.lg,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    )
                  ],
                  DsVerticalSpace.xxl,
                  BottomInformationWidget(
                    unit: state.units,
                    wind: '${state.weather.current.windSpeed.toInt()}',
                    humidity: '${state.weather.current.humidity}',
                    sessation: '${state.weather.current.feelsLike.toInt()}',
                    symbol: symbol,
                  ),
                  DsVerticalSpace.xxl,
                  DsVerticalSpace.xxl,
                  DsVerticalSpace.xxl,
                  DsVerticalSpace.xxl,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget loadSvgIcon(String name, {double width = 150, double height = 150}) {
    if (name.isEmpty) throw FlutterError('No image');

    return SizedBox(
      height: 175,
      child: SvgPicture.asset(
        'assets/icons/$name.svg',
        semanticsLabel: 'A weather icon',
        width: 200,
        placeholderBuilder: (context) => SvgPicture.asset(
          'assets/icons/clear sky.svg',
          semanticsLabel: 'A weather icon',
          height: 150,
        ),
      ),
    );
  }
}
