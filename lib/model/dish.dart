class Dish{
  String? imageUrl;
  String? name;
  // String? categories;
  int? price;
  Map? discount={'flatDiscount': 0, 'percentageDiscount':0};
  double? ratings;

  Dish(this.imageUrl, this.name, this.discount,
      this.price, this.ratings);

  toMap()=>{
    "imageUrl": imageUrl,
    "name": name,
    "discount": discount,
    "price": price,
    "ratings": ratings,
  };

  @override
  String toString() {
    return 'Restaurant{imageUrl: $imageUrl, name: $name, price: $price, discount: $discount, ratings: $ratings}';
  }


// sort(){}


}