import 'package:contact_diary/controller/povider.dart';
import 'package:contact_diary/view/detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailPage extends StatefulWidget {
  const ContactDetailPage({super.key});

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  @override
  Widget build(BuildContext context) {
    var aargu = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer<ContactProvider>(
          builder:
              (BuildContext context, ContactProvider value, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(
                    "${value.contactList[aargu].name ?? " "}"[0].toUpperCase(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${value.contactList[aargu].name ?? " "} ${value.contactList[aargu].sname ?? " "}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        launchUrl(Uri.parse(
                            "tel:${value.contactList[aargu].number ?? " "}"));
                      },
                      icon: Icon(Icons.call),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailPage(
                                index: aargu,
                              );
                            },
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Provider.of<ContactProvider>(context, listen: false)
                            .deleteContact(aargu);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.delete),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black12),
                      ),
                      onPressed: () {
                        Share.share("${value.contactList[aargu].number}");
                      },
                      icon: Icon(Icons.share),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Mobile  :  ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "${value.contactList[aargu].number ?? " "}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email  :  ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "${value.contactList[aargu].email ?? " "}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
