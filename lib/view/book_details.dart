import 'package:flutter/material.dart';
import 'package:login/API%20services/api_services.dart';
import 'package:login/model/book_model.dart';

class BookDetailsPage extends StatelessWidget {
  final String id;

  const BookDetailsPage({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Title")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<BookDetails>(
          future: ApiServices.fetchProductsUsingId(id),
          builder: (context, snapshot) {
           if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
           }else if(snapshot.hasError){
            return Text("Error: ${snapshot.error}");
           }else{
            final bookid=snapshot.data!;
            return ListView(children: [
            Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(image: DecorationImage(image:NetworkImage(bookid.items![0].volumeInfo!.imageLinks!.thumbnail.toString()),fit: BoxFit.contain)),
            ),
            const SizedBox(height: 10,),
            Center(child: Text(bookid.items![0].volumeInfo!.title.toString(),style: const TextStyle(fontSize: 25),)),
            const SizedBox(height: 10,),
            const Text("Author Name :",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            Text(bookid.items![0].volumeInfo!.authors!.join(","),style: const TextStyle(fontSize: 25),),
            const SizedBox(height: 10,),
            const Text("Selfi Link :",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            Text(bookid.items![0].selfLink.toString(),style: const TextStyle(fontSize: 20,color: Colors.blue),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Column(
              children: [
                Text("Page Count",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                Text(bookid.items![0].volumeInfo!.pageCount.toString(),style: const TextStyle(fontSize: 20,)),
              ],
            ),
             Column(
              children: [
                Text("Categories",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                Text(bookid.items![0].volumeInfo!.categories!.join(","),style: const TextStyle(fontSize: 20,)),
              ],
            )
            ],),
            const SizedBox(height: 10,),
            const Text("Discription :",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              width: double.maxFinite,
              height: 400,
              child: SingleChildScrollView(
                child: Text(bookid.items![0].volumeInfo!.description.toString(),style: const TextStyle(fontSize: 20),),
              ),
            ),
            const SizedBox(height: 20,)
            ]);
           }
          }
        ),
      ),
    );
  }
}

