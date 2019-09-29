import 'package:flutter/material.dart';

class VideoItem extends StatelessWidget {
  final String videoId;
  final String title;
  final String image;
  final String channelTitle;

  VideoItem(this.videoId, this.title, this.channelTitle, this.image);

  void _detailScreen(BuildContext context) {
    Navigator.of(context).pushNamed('/detail', arguments: videoId);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _detailScreen(context),
          child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 15,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  IconTheme(data: IconThemeData(color: Colors.blueGrey), child: Icon(Icons.shop_two),),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(child: Text('Channel: $channelTitle', style: TextStyle(color: Colors.blueGrey),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
