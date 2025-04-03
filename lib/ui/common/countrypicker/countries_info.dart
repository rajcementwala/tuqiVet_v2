import 'package:collection/collection.dart';
import 'country_dial_info.dart';

class CountriesInfo {
  late List<CountryInfo> countries;
  static final CountriesInfo _singleton = CountriesInfo._internal();

  factory CountriesInfo() {
    return _singleton;
  }

  CountriesInfo._internal() {
    countries = countriesState.map((e) => CountryInfo.fromJson(e)).toList();
    countries.sort((a, b) => a.name.compareTo(b.name));
  }

  CountryInfo? getCountryInfoByPhoneCode(String code) {
    return countries.firstWhereOrNull((element) => element.phoneCode == code);
  }

  CountryInfo? getCountryInfoByRegionCode(String code) {
    return countries.firstWhereOrNull((element) => element.code == code);
  }

  static StateInfo? getStateInfoByStateName({
    required CountryInfo countryInfo,
    required String stateName,
  }) {
    return countryInfo.states
        .firstWhereOrNull((element) => element.name == stateName);
  }

  Tuple? seperatePhoneAndDialCode(String phoneWithDialCode) {
    var countriesCode = countries.map((element) => element.phoneCode).toList();
    countriesCode.sort((a, b) => b.length.compareTo(a.length));
    String? phoneCode;
    for (var code in countriesCode) {
      if (phoneWithDialCode.contains(code)) {
        phoneCode = code;
        break;
      }
    }

    if (phoneCode != null) {
      final foundedCountry = countries
          .firstWhereOrNull((element) => element.phoneCode == phoneCode);
      if (foundedCountry != null) {
        var newPhoneNumber = phoneWithDialCode.substring(
          foundedCountry.phoneCode.length,
        );
        return Tuple<CountryInfo, String>(
          item1: foundedCountry,
          item2: newPhoneNumber,
        );
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

class CountryInfo {
  final String name;
  final String flag;
  final String code;
  final String code2;
  final String code3;
  final String capital;
  final String region;
  final String subregion;
  final String phoneCode;
  final List<StateInfo> states;

  CountryInfo({
    required this.name,
    required this.flag,
    required this.code,
    required this.code2,
    required this.code3,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.phoneCode,
    required this.states,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    var tmpStates = <StateInfo>[];
    if (json['states'] != null) {
      json['states'].forEach((v) {
        tmpStates.add(StateInfo.fromJson(v));
      });
    }
    return CountryInfo(
      name: json['name'] ?? '',
      flag: json['flag'] ?? '',
      code: json['code'] ?? '',
      code2: json['code2'] ?? '',
      code3: json['code3'] ?? '',
      capital: json['capital'] ?? '',
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      phoneCode: json['phoneCode'] ?? '',
      states: tmpStates,
    );
  }
}

class StateInfo {
  final String code;
  final String name;
  final String? subdivision;

  StateInfo({
    required this.code,
    required this.name,
    this.subdivision,
  });

  factory StateInfo.fromJson(Map<String, dynamic> json) {
    return StateInfo(
      name: json['name'] ?? '',
      code: json['flag'] ?? '',
      subdivision: json['subdivision'] ?? '',
    );
  }
}

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple({
    required this.item1,
    required this.item2,
  });
}
