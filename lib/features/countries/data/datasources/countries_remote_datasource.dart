import '../models/country_summary_model.dart';
import '../models/country_detail_model.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';

abstract class CountriesRemoteDataSource {
  Future<List<CountrySummaryModel>> getAllCountries();
  Future<List<CountrySummaryModel>> searchCountries(String name);
  Future<CountryDetailModel> getCountryDetails(String code);
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  final DioClient client;

  CountriesRemoteDataSourceImpl(this.client);

  @override
  Future<List<CountrySummaryModel>> getAllCountries() async {
    try {
      final response = await client.get(ApiConstants.allCountries);
      return (response.data as List)
          .map((json) => CountrySummaryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<CountrySummaryModel>> searchCountries(String name) async {
    try {
      final response = await client.get(ApiConstants.searchByName(name));
      return (response.data as List)
          .map((json) => CountrySummaryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<CountryDetailModel> getCountryDetails(String code) async {
    try {
      final response = await client.get(ApiConstants.getByCode(code));
      return CountryDetailModel.fromJson(response.data);
    } catch (e) {
      throw ServerException();
    }
  }
}
