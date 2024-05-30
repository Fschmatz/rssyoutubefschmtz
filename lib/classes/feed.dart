import 'package:jiffy/jiffy.dart';

class Feed {

  final String title;
  final String link;
  final String author;
  final String date;
  final String linkImagem;

  Feed({required this.title,required this.link,required this.date,required this.linkImagem,required this.author});

  String getFormattedDate(){
    return Jiffy(date).format("dd/MM/yyyy");
  }
}