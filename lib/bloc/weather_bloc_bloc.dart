import 'package:bloc/bloc.dart';
import 'package:bloc_weather_app/data/my_data.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherBlocLoadingState());

      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        print(weather);
        emit(WeatherBlocSuccessState(weather));
      } catch (e) {
        emit(WeatherBlocFailureState());
      }
    });
  }
}
