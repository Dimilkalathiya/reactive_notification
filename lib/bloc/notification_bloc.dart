import 'dart:async';

import 'package:hive/hive.dart';
import 'package:reactive_notifcation/models/notification_model.dart';

const hiveNotificationBox = "notificatons";

class NotificationBloc {
  final notificationController =
      StreamController<List<NotificationModel>>.broadcast();
  Stream<List<NotificationModel>> get notificationStream =>
      notificationController.stream;

  Future<void> insertNotification(NotificationModel data) async {
    final box = await Hive.openBox<NotificationModel>(hiveNotificationBox);
    box.add(data);
    List<NotificationModel> allData = box.values.toList();
    box.close();
    notificationController.sink.add(allData);
  }

  Future<void> fetchNotification() async {
    final box = await Hive.openBox<NotificationModel>(hiveNotificationBox);
    List<NotificationModel> allData = box.values.toList();
    box.close();
    notificationController.sink.add(allData);
  }

  Future<void> deleteNotification(NotificationModel data) async {
    final box = await Hive.openBox<NotificationModel>(hiveNotificationBox);
    box.delete(data.key);
    List<NotificationModel> allData = box.values.toList();
    notificationController.sink.add(allData);
  }

  dispose() {
    notificationController.close();
  }
}

NotificationBloc notificationBloc = NotificationBloc();
