import 'package:flutter/material.dart';
import 'package:doanthuchanh/model/bill.dart';

class HistoryDetail extends StatelessWidget {
  final List<BillDetailModel> bill;

  const HistoryDetail({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Details'),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 215, 231, 247),
        child: ListView.builder(
          itemCount: bill.length,
          itemBuilder: (context, index) {
            var data = bill[index];
            return Card(
              color: Color.fromARGB(255, 165, 213, 250),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.productName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Center(
                      child: Image.network(
                        data.imageUrl,
                        height: 160.0,
                        width: 180,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Price: \$${data.price.toString()}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Total: \$${data.total.toString()}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
