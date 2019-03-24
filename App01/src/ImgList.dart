import 'package:flutter/material.dart';
import './img_mod.dart';

class ImgList extends StatelessWidget {
  final List<ImgMod> img;

  ImgList(this.img);

  Widget build(context) {
    return ListView.builder(
        itemCount: img.length,
        itemBuilder: (context, int i){
          //return Image.network(img[i].url);
          return buildImg(img[i]);
        }
    );
  }

  Widget buildImg(ImgMod img){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey)
      ),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(20.0),
      //child: Image.network(img.url),
      child: Column(
        children: <Widget>[
          Padding(
            child: Image.network(img.url),
              padding: EdgeInsets.only(bottom: 8.0),
          ),
          Text(img.title),
        ],
      ),
    );
  }
}
