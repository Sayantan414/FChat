import 'package:f_chat/api/apis.dart';
import 'package:f_chat/helper/dialogs.dart';
import 'package:f_chat/main.dart';
import 'package:f_chat/models/chat_user.dart';
import 'package:f_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});
  final ChatUser user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              title: const Text('Profile'),
              titleTextStyle: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                // fontStyle: FontStyle.italic,
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.redAccent,
              onPressed: () async {
                Dialogs.showProgressbar(context);
                await APIs.auth.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  });
                });
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20), // Adjust the value as needed
                          child: CircleAvatar(
                            radius: 60, // Adjust the value as needed
                            backgroundImage: widget.user.image != ''
                                ? NetworkImage(widget.user.image)
                                : null,
                            child: widget.user.image == ''
                                ? const Icon(Icons.person)
                                : null,
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: MaterialButton(
                            onPressed: () {},
                            shape: const CircleBorder(),
                            color: Colors.white,
                            child: const Icon(Icons.edit, color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: mq.height * .03),
                    Text(
                      widget.user.email,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(height: mq.height * .05),
                    TextFormField(
                      initialValue: widget.user.name,
                      onSaved: (val) => APIs.me.name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'eg. Your Name',
                          label: const Text('Name')),
                    ),
                    SizedBox(height: mq.height * .03),
                    TextFormField(
                      initialValue: widget.user.about,
                      onSaved: (val) => APIs.me.about = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.info_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'eg. Feeling Happy!',
                          label: const Text('About')),
                    ),
                    SizedBox(height: mq.height * .05),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(mq.width * .4, mq.height * .055)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          APIs.updateUserInfo().then((value) {
                            Dialogs.showSnackbar(
                                context, "Profile Updated Successfully!");
                          });
                        }
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('UPDATE'),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
