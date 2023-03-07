class SliderObject {
  String title;
  String subtitle;
  String image;

  SliderObject(this.title, this.subtitle, this.image);
}

class Customer {
  int id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String email;
  String phone;
  String link;

  Contacts(this.email, this.phone, this.link);
}

class Authentication {
  Customer customer;
  Contacts contacts;

  Authentication(this.customer, this.contacts);
}
