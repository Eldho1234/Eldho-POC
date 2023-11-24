import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String imgUrl;
  final String text;
  final String text1;
  final String text2;
  final String text3;

  const ProductTile(
      {super.key,
      required this.imgUrl,
      required this.text,
      required this.text1,
      required this.text2,
      required this.text3,});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
           Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           Text(text),
           const SizedBox(height: 8),
           Text("Authors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           Text(text1),
           const SizedBox(height: 8),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Column(
                 children: [
                   Text("Page count",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                   Text(text2),
                 ],
               ),
               Column(
                 children: [
                   Text("Country",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                   Text(text3),
                 ],
               ),
             ],
           ),

          ],
        ),
      ),
    );
  }
}

// 