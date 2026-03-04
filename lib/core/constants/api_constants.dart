class ApiConstants {
  static const String baseUrl = 'https://restcountries.com/v3.1';
  static const String allCountries = '/all?fields=name,flags,population,cca2';
  static String searchByName(String name) => '/name/$name?fields=name,flags,population,cca2';
  static String getByCode(String code) => '/alpha/$code?fields=name,flags,population,capital,region,subregion,area,timezones,cca2';
}
