import 'package:zeta/zermelo/Announcement/Announcement.dart';
import 'package:zeta/zermelo/Manager.dart';
import 'package:http/http.dart' as http;
import 'package:zeta/zermelo/Util.dart';
import 'dart:convert';

class AnnouncementsManager extends ZermeloManager {
  String school;
  String accessToken;

  get({user = "~me"}) async {
    final response = await http.get(ZermeloUtil.createApiURL(this.school,
        "announcements?user=$user&current=true", this.accessToken));
    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map((school) => Announcement.fromJson(json.decode(school)))
          .toList()
          .sort((a, b) => a.start.compareTo(b.start));
    } else {
      throw Exception('Failed to load announcement');
    }
  }

  AnnouncementsManager(String school, String accesstoken) {
    this.school = school;
    this.accessToken = accesstoken;
  }
}
