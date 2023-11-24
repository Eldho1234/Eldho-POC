import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:login/API%20services/api_services.dart';
import 'package:login/view/book_details.dart';
import 'package:login/widget/custom_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Page"),),
      body: FutureBuilder(future: ApiServices.fetchProducts(), builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError){
          return Text("Error: ${snapshot.error}");
        }else{
          final bookDetails=snapshot.data!;
          return StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            itemCount: bookDetails.items!.length,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            itemBuilder: (context, index) {
                              final products=bookDetails.items;
                              final product = products![index];
                              return GestureDetector(
                                onTap: () {
                                Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookDetailsPage(id: product.id.toString(),),
                                      ));
                                },
                                child: ProductTile(
                                  imgUrl:bookDetails.items![index].volumeInfo!.imageLinks!.smallThumbnail.toString() , 
                                  text: bookDetails.items![index].volumeInfo!.title.toString(),
                                  text1:bookDetails.items![index].volumeInfo!.authors!.join(" ").toString() ,
                                  text2: bookDetails.items![index].volumeInfo!.pageCount.toString(),
                                  text3: bookDetails.items![index].accessInfo!.country.toString(),

                                ),
                              );
                            },
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.fit(1),
                          );
        }
      },),
    );
  }
}