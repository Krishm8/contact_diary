import 'package:contact_diary/controller/povider.dart';
import 'package:contact_diary/modal/contact_modal.dart';
import 'package:contact_diary/view/contactdetail.dart';
import 'package:contact_diary/view/detail.dart';
import 'package:contact_diary/view/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var acolor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: acolor,
        title: Text("Contacts"),
        actions: [
          IconButton(
            onPressed: () async {
              var instance = await SharedPreferences.getInstance();
              instance.setBool("isLogin", false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                CheckedPopupMenuItem(
                  onTap: () {
                    acolor=Colors.red;
                    setState(() {

                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Text("red"),
                ),
                CheckedPopupMenuItem(
                  onTap: () {
                    acolor=Colors.blue;
                    setState(() {

                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Text("blue"),
                ),
                CheckedPopupMenuItem(
                  onTap: () {
                    acolor=Colors.green;
                    setState(() {

                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Text("green"),
                ),
                CheckedPopupMenuItem(
                  onTap: () {
                    acolor=Colors.white;
                    setState(() {

                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Text("white"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.contactList.length,
            itemBuilder: (context, index) {
              ContactModal contact = value.contactList[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "contctdetail",arguments: index);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text("${contact.name ?? ""}"[0].toUpperCase()),
                  ),
                  title: Text("${contact.name ?? ""}  ${contact.sname ?? ""}"),
                  subtitle: Text(contact.number ?? ""),
                  trailing: InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(
                          "tel:${value.contactList[index].number ?? " "}"));
                    },
                    child: Icon(Icons.call),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "detail");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


/*
Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailPage(
                          index: index,
                        );
                      },
                    ),
                  );
 */