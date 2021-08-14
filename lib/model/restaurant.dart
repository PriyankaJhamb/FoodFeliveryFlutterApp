class Restaurant{
  String? imageUrl;
  String? name;
  String? categories;
  int? pricePerPerson;
  double? ratings;

  Restaurant(this.imageUrl, this.name, this.categories,
      this.pricePerPerson, this.ratings);

  toMap()=>{
    "imageUrl": imageUrl,
    "name": name,
    "categories": categories,
    "pricePerPerson": pricePerPerson,
    "ratings": ratings,
  };

  @override
  String toString() {
    return 'Restaurant{imageUrl: $imageUrl, name: $name, categories: $categories, pricePerPerson: $pricePerPerson, ratings: $ratings}';
  }

// sort(){}


}