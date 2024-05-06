import 'package:contact_diary/controller/povider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  int? index;

  DetailPage({super.key, this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int ci = 0;
  TextEditingController fname = TextEditingController();
  TextEditingController sname = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();

  GlobalKey<FormState> fkey = GlobalKey<FormState>();
  GlobalKey<FormState> skey = GlobalKey<FormState>();
  GlobalKey<FormState> pkey = GlobalKey<FormState>();
  GlobalKey<FormState> ekey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.index != null) {
      var nameVal = Provider.of<ContactProvider>(context, listen: false)
          .contactList[widget.index!];
      fname.text = nameVal.name ?? "";
      sname.text = nameVal.sname ?? "";
      number.text = nameVal.number ?? "";
      email.text = nameVal.email ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index != null ? "Edit Contact" : "Add Contact"),
      ),
      body: Stepper(
        currentStep: ci,
        onStepTapped: (index) {
          ci = index;
          setState(() {});
        },
        onStepContinue: () {
          if (ci == 0) {
            var fvalid = fkey.currentState?.validate();
            if (fvalid == true) {
              ci++;
              setState(() {});
            }
          } else if (ci == 1) {
            var fvalid = skey.currentState?.validate();
            if (fvalid == true) {
              ci++;
              setState(() {});
            }
          } else if (ci == 2) {
            var fvalid = pkey.currentState?.validate();
            if (fvalid == true) {
              ci++;
              setState(() {});
            }
          } else if (ci == 3) {
            var fvalid = ekey.currentState?.validate();

            if (fvalid == true) {

              if (widget.index != null) {

                Provider.of<ContactProvider>(context, listen: false)
                    .editContact(widget.index!, fname.text, sname.text,
                        number.text, email.text);
                Navigator.pop(context);
              } else {
                Provider.of<ContactProvider>(context, listen: false).addContact(
                    fname.text, sname.text, number.text, email.text);
                Navigator.pop(context);
              }
            }
          }
        },
        onStepCancel: () {
          if (ci > 0) {
            ci--;
            setState(() {});
          }
        },
        steps: [
          Step(
            title: Text("First Name"),
            content: Form(
              key: fkey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter first name";
                  }
                },
                controller: fname,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Enter First Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            isActive: 0 <= ci,
          ),
          Step(
            title: Text("Second Name"),
            content: Form(
              key: skey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter second name";
                  }
                },
                controller: sname,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Enter Second Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            isActive: 1 <= ci,
          ),
          Step(
            title: Text("Phone Number"),
            content: Form(
              key: pkey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone number";
                  }
                },
                controller: number,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            isActive: 2 <= ci,
          ),
          Step(
            title: Text("Email"),
            content: Form(
              key: ekey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter email";
                  }
                },
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter Email Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            isActive: 3 <= ci,
          ),
        ],
      ),
    );
  }
}
