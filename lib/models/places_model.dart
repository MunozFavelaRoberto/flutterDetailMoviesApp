class PlacesModel{
  String? titlePlace;
  String? imgPlace;
  double? latPlace;
  double? lonPlace;
  String? dscPlace;

  PlacesModel({
    this.titlePlace,
    this.imgPlace,
    this.latPlace,
    this.lonPlace,
    this.dscPlace
    });

    Map<String,dynamic>toMap(){//factory es para los constructores nombrados.
      return{
        'titlePlace' : this.titlePlace,
        'imgPlace' : this.imgPlace,
        'latPlace' : this.latPlace,
        'lonPlace' : this.lonPlace,
        'dscPlace' : this.dscPlace
      };      
    }
}