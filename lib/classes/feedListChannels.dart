import 'package:rssyoutubefschmtz/classes/channelFeed.dart';

class FeedListChannels{

  List<ChannelFeed> listChannels = [];

  //DB???
  List<ChannelFeed> getFeedListChannels() {
      listChannels.add(new ChannelFeed(
          name: 'Curso Em Vídeo',
          linkFeed:
          'https://www.youtube.com/feeds/videos.xml?channel_id=UCrWvhVmt0Qac3HgsjQK62FQ'));
      listChannels.add(new ChannelFeed(
          name: 'freeCodeCamp.org',
          linkFeed:
          'https://www.youtube.com/feeds/videos.xml?channel_id=UC8butISFwT-Wl7EV0hUK0BQ'));
      listChannels.add(new ChannelFeed(
          name: 'Fun With Flutter',
          linkFeed:
          'https://www.youtube.com/feeds/videos.xml?channel_id=UCU8Mj6LLoNBXqqeoOD64tFg'));
      listChannels.add(new ChannelFeed(
          name: 'The Net Ninja',
          linkFeed:
          'https://www.youtube.com/feeds/videos.xml?channel_id=UCW5YeuERMmlnqo4oq8vwUpg'));
      listChannels.add(new ChannelFeed(
          name: 'The Coding Train',
          linkFeed:
          'https://www.youtube.com/feeds/videos.xml?channel_id=UCvjgXvBlbQiydffZU7m1_aw'));
    return listChannels;
  }

}
//for(int i = 0; i < 5 ; i++)