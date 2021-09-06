class Order{
  List? dishes;
  int? total;
  String? restaurantID;
  String? address;

  Order({this.dishes, this.total, this.restaurantID, this.address});

  @override
  String toString() {
    return 'Order{dishes: $dishes, total: $total, restaurantID: $restaurantID, address: $address}';
  }

  toMap()=>{
    'dishes': dishes,
    'total': total,
    'restaurantID' : restaurantID,
    'address':address
  };
}