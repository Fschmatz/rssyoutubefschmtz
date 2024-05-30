import 'package:jiffy/jiffy.dart';

class WatchLaterFeed {

  final int id;
  final String title;
  final String link;
  final String author;
  final String date;

  WatchLaterFeed({required this.id,required this.title,required this.link,required this.date,required this.author});

  String getFormattedDate(){
    return Jiffy(date).format("dd/MM/yyyy");
  }

}