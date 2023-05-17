import 'package:flutter/cupertino.dart';
import 'package:flutterfire/pages/fireStore/insert_data_page.dart';
import 'package:flutterfire/pages/fireStore/update_data_page.dart';

import '../fireStore/fetch_data_list.dart';

final Map<String, WidgetBuilder> routes = {
  FetchDataList.routeName: (context) => const FetchDataList(),
  InsertDataPage.routeName: (context) => const InsertDataPage(),
  UpdateDataPage.routeName: (context) => const UpdateDataPage(),
};
