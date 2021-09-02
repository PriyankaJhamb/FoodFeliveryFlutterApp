//This is what we will add in the cart

class DishModelForCartPage{
  String? name;
  int? price;
  int? quantity;
  int? totalprice;
  String? imageUrl;

  DishModelForCartPage({this.name, this.price, this.quantity, this.totalprice, this.imageUrl});

  @override
  String toString() {
    return 'DishModelForCartPage{name: $name, price: $price, quantity: $quantity, totalprice: $totalprice, imageUrl: $imageUrl}';
  }

  toMap()=>{
    "name": name,
    "price": price,
    "quantity": quantity,
    "totalprice": totalprice,
    "imageUrl": imageUrl
  };
}