class OrderModel {
  final String userId;
  final String pickupLocation;
  final String dropOffLocation;
  final String packageDetails;
  final String status;
  dynamic timestamp;

  OrderModel({
  required this.userId,
   required this.pickupLocation, 
   required this.dropOffLocation, 
   required this.packageDetails, 
   required this.status, });
}

