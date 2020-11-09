import 'package:flutter/material.dart';
import '../models/slide_model.dart';

class SlideItem extends StatelessWidget {
  // const SlideItem({Key key}) : super(key: key);

  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: 40.0,
        // ),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage(slidelist[index].imageUrl),
                // fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 40.0,
        ),
        Text(slidelist[index].title,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 22, color: Theme.of(context).primaryColor)),
        SizedBox(
          height: 20.0,
        ),
        Text(slidelist[index].description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0, color: Colors.black)),
        // SizedBox(
        //   height: 20.0,
        // ),
      ],
    );
  }
}
