
import 'package:flutter/material.dart';
import 'package:quick_deliver/features/address/user_address.dart';
import 'package:quick_deliver/features/order/orders.dart';
import 'package:quick_deliver/services.dart/auth_service.dart';
import 'package:quick_deliver/theme/text_style.dart' show bodyMedium;
import 'package:quick_deliver/theme/theme.dart';
import 'package:quick_deliver/services.dart/firestore_service.dart';
import 'package:quick_deliver/services.dart/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();
  final detailsController = TextEditingController();
  List<String> suggestions = [];
  String? pickupAddress;
  String? dropoffAddress;
  

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      suggestions = prefs.getStringList('recent_addresses') ?? [];
    });
  }

Future<void> _saveAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existing = [
      pickupController.text,
      dropoffController.text,
      ...?prefs.getStringList('recent_addresses')
    ]
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList();
    await prefs.setStringList(
        'recent_addresses', existing.take(5).toList());
    setState(() => suggestions = existing);
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: (){
              AuthService().signOut();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Logout', style: bodyMedium(color: Colors.red),),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                           onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders())),
                          child: Card(
                            color: AppTheme.primary,
                            elevation: 0.6,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Text('View orders',  style: bodyMedium(color: Colors.white),),
                            ),
                          ),
                        ),
                      ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to quick deliver!",
                            style: AppTheme.themeData().textTheme.titleLarge,
                          ),
                          SizedBox(height: 5,),
                          const Text(
                            'Our riders are always available to receive your order, send your order by filling the form.',
                            maxLines: 2,
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Pick up Location',
                    style: AppTheme.themeData().textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AddressField(
             
              controller: pickupController,
              suggestions: suggestions,
            ),
                     const SizedBox(
                    height: 20,
                  ),
                  
                  Text(
                    'Drop off location',
                    style: AppTheme.themeData().textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
               AddressField(
              controller: dropoffController,
              suggestions: suggestions,
            ),
            const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Packages details',
                    style: AppTheme.themeData().textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: detailsController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintStyle: AppTheme.themeData().textTheme.bodyMedium,
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                    ),
                    keyboardType: TextInputType.multiline,
                    
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    
                    onTap:()async{ 
                      FirestoreService().createOrder(
                       pickupLocation:  pickupController.text.trim(), 
                       dropOffLocation: dropoffController.text.trim(), 
                        packageDetails: detailsController.text.trim());
                       NotificationService.showNotification(title: 'Delivery request', body: 'Thank for your request. A rider will get back to you.');
                      await _saveAddresses();
                      pickupController.clear();
                      dropoffController.clear();
                      detailsController.clear();
                    },
                    child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppTheme.primary,
                        ),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: bodyMedium(color: Colors.white),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  
                  
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}