

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:materimei30/data/model/request/admin/posting_jual_request_model.dart';
import 'package:materimei30/data/model/response/burung_semua_tersedia_model.dart';
import 'package:materimei30/data/model/response/get_all_burung_response_model.dart';
import 'package:materimei30/service/service_http_client.dart';

class PostingRepository {
  final ServiceHttpClient _serviceHttpClient;
  PostingRepository(this._serviceHttpClient);

  Future<Either<String, BurungSemuaTersediabyIdModel>> addPostBurung(
    PostingJualRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWihToken(
        'admin/posting-jual',
        requestModel.toJson(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse = BurungSemuaTersediabyIdModel.fromJson(
          jsonResponse,
        );
        log("Add Burung  successful: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add burung failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Add burung failed");
      }
    } catch (e) {
      log("Error in Add burung : $e");
      return Left("An error occurred while post burung: $e");
    }
  }
}
