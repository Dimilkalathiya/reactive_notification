import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 0)
class NotificationModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String subtitle;

  NotificationModel(this.title, this.subtitle);
}
