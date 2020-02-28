class Vendor{
  String vname;
  int id;

  Vendor(this.vname,this.id);

    Map<String, dynamic> toMap() {
    return {
      'vname' : vname,
      'id': id,
    };
  }
  Vendor.fromMap(Map<String,dynamic> map){
    id = map['id'];
    vname = map['vname'];
  }
}