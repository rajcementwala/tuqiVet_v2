// ignore_for_file: prefer_interpolation_to_compose_strings, constant_identifier_names
const String API_URL = 'https://git.aksinfotech.in/api/';
const String API_KEY = 'api_key';

abstract class Apis {
  ///On-boarding APIs
  static const login = API_URL + 'Authentication/Login';
  static const registration = API_URL + 'registration';
  static const users = API_URL + 'users';
}
