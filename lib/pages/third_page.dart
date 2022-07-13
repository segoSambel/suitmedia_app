import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suitmedia_app/components/custom_appbar.dart';
import 'package:suitmedia_app/components/user_details.dart';
import 'package:suitmedia_app/models/users_data.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  int page = 1;
  late int totalPages;
  List<User> users = [];
  final _smartRefreshController = RefreshController(initialRefresh: true);

  Future<bool> fetchData({bool isFirstLoad = false}) async {
    if (isFirstLoad) {
      page = 1;
    } else {
      if (page > totalPages) {
        _smartRefreshController.loadNoData();
        return false;
      }
    }

    final response = await http
        .get(Uri.parse("https://reqres.in/api/users?per_page=8&page=$page"));

    if (response.statusCode == 200) {
      final res = usersDataFromJson(response.body);
      if (isFirstLoad) {
        users = res.data;
      } else {
        users.addAll(res.data);
      }
      page++;
      totalPages = res.totalPages;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _smartRefreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Third Page"),
      body: SmartRefresher(
        controller: _smartRefreshController,
        enablePullUp: true,
        onRefresh: () async {
          final res = await fetchData(isFirstLoad: true);
          if (res) {
            _smartRefreshController.refreshCompleted();
          } else {
            _smartRefreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final res = await fetchData();
          if (res) {
            _smartRefreshController.loadComplete();
          } else {
            _smartRefreshController.loadFailed();
          }
        },
        child: ListView.separated(
            itemBuilder: (_, index) {
              final user = users[index];
              return UserDetails(user: user);
            },
            separatorBuilder: (_, __) => const Divider(
                  thickness: 0.1,
                  height: 0.1,
                ),
            itemCount: users.length),
      ),
    );
  }
}
