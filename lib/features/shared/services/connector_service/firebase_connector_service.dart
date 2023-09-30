import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:astrolex/app/get_it.dart';
import 'package:astrolex/features/shared/services/connector_service/fast_connector_service.dart';

@Injectable(as: FastConnectorService)
class FirebaseConnectorService extends FastConnectorService {
  @override
  DateTime? getDateTimeFromTimestamp(dynamic timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp? getTimestampFromDateTime(DateTime? dateTime) {
    return Timestamp.fromDate(dateTime!);
  }
}
