
import 'package:flutter/material.dart';
import 'package:quick_deliver/components/order_status_tracking.dart';
import 'package:quick_deliver/services.dart/firestore_service.dart';
import 'package:quick_deliver/theme/theme.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;
  
  const OrderDetails({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: FirestoreService().getOrderById(widget.orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Order not found.'));
          }

          final order = snapshot.data!;
       

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text('Order Status', style:  AppTheme.themeData().textTheme.titleSmall),
                const SizedBox(height: 20),
                OrderProgressStepper( status: order['status'],),
               Text('Order Details', style:  AppTheme.themeData().textTheme.titleSmall),
                const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
               Text('Order Description', style:  AppTheme.themeData().textTheme.titleSmall),
               Text(order['packageDetails'])
              ],
            ),
          );
        },
      ),
    );
  }
}
