import 'package:contact_diary/modal/contact_modal.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModal> contactList = [];

  void addContact(String name, String sname, String number, String email) {
    contactList.add(
        ContactModal(name: name, number: number, sname: sname, email: email));
    notifyListeners();
  }

  void deleteContact(int index) {
    contactList.removeAt(index);
    notifyListeners();
  }

  void editContact(
    int index,
    String fname,
    String sname,
    String number,
    String email,
  ) {
    contactList[index] = ContactModal(
      name: fname,
      sname: sname,
      number: number,
      email: email,
    );
    notifyListeners();
  }
}
