import 'package:flutter/material.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/helper/sqldb.dart';
import 'package:news_app/services/notification_service.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  final String? id;
  const NotificationScreen({Key? key, @required this.id}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    super.initState();
  }

  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM notification');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: FutureBuilder(
          future: readData(),
          builder: (context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              List<Map<dynamic, dynamic>>? notificationData = snapshot.data;
              List<Map<dynamic, dynamic>>? lastTenNotifications = [];
              if (notificationData!.length >= 10) {
                lastTenNotifications =
                    notificationData.sublist(notificationData.length - 10);
                lastTenNotifications = lastTenNotifications.reversed.toList();
              } else {
                lastTenNotifications = notificationData;
                lastTenNotifications = lastTenNotifications.reversed.toList();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: lastTenNotifications.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      // trailing: IconButton(onPressed: (){
                      //   showDialog(
                      //     context: context,
                      //     builder: (context) => AlertDialog(
                      //       title: const Text('هل انت متأكد من ازالة هذا الاشعار'),
                      //       actions: [
                      //         CustomTextButton(
                      //           text: 'الغاء',
                      //           textColor: Colors.red,
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //         ),
                      //         CustomTextButton(
                      //
                      //           text: 'موافق',
                      //           onPressed: () async {
                      //             sqlDb.deleteData('DELETE FROM "notificaton" WHERE "$kNotificationTitle" = ${notificationData[index][kNotificationTitle]}');
                      //             print('deleted ${notificationData[index][kNotificationTitle]}');
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   );
                      // }, icon: Icon(Icons.delete)),
                      title: Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Text(
                            lastTenNotifications![index][kNotificationTitle]),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                            lastTenNotifications[index][kNotificationBody]),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
