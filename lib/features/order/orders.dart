import 'package:flutter/material.dart';
import 'package:quick_deliver/features/order/order_details.dart';
import 'package:quick_deliver/theme/text_style.dart';
import 'package:quick_deliver/services.dart/firestore_service.dart';

class MyOrders extends StatefulWidget {
  
  const MyOrders({super.key,});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders')),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirestoreService().getUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          final orders = snapshot.data!;
          

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
             
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails(orderId: order['id']))),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                        
                        Text(order['status'] ?? 'Pending',style: bodyMedium(color: Colors.orange),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pick up Location:'),
                            Text('${order['pickupLocation']}')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Drop off Location:'),
                            Text('${order['dropOffLocation']}')
                          ],
                        ),
                        Text(order['id'])
                      ],),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
