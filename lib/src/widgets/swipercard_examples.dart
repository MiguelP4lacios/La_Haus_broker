import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_bloc_pattern/model/swiper_examples_model.dart';

class SwiperCard extends StatelessWidget {
  // final int index;
  // SwiperCard(this.index);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Swiper(
      // viewportFraction: 2.0,
      loop: false,
      containerWidth: 5.0,
      containerHeight: 5.0,
      layout: SwiperLayout.TINDER,
      itemWidth: _screenSize.width * 1,
      itemHeight: _screenSize.height * 0.5,
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                color: Colors.blue[50],
                child: Column(
                  children: [
                    FadeInImage(
                      height: _screenSize.height * 0.37,
                      width: _screenSize.width * 0.8,
                      fit: BoxFit.scaleDown,
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: AssetImage(cardlist[index].imageUrl),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      cardlist[index].description,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                )));
      },
      itemCount: cardlist.length,
      pagination: new SwiperPagination(),
      // control: new SwiperControl(),
    );
  }
}
