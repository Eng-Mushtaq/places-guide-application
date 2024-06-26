import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:places/authintication/screens/signin.dart';
import 'package:places/home/drawer/components/help_support.dart';
import 'package:places/home/drawer/components/my_account.dart';
import 'package:places/home/drawer/components/my_bookings.dart';
import 'package:places/home/drawer/components/settings.dart';
// import '../../auth/service/login_sign.dart';
import '../../global/global.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final name = sharedPreferences!.getString("fullName");
    // const email = 'sarah@abs.com';
    // const urlImage =
    //  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    return Drawer(
      child: Material(
        color: Colors.deepPurple,
        child: ListView(
          children: <Widget>[
            buildHeader(
              //urlImage: urlImage,
              name: name ?? 'No Account',
              // email: email,
              // ignore: avoid_returning_null_for_void
              onClicked: () => null,
              //  Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const UserPage(
              //       name: 'Sarah Abs',
              //       urlImage: urlImage,
              //     ),
              //   ),
              // ),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white70),
                  //  buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'My Account',
                    icon: Icons.person,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  // const SizedBox(height: 16),
                  // buildMenuItem(
                  //   text: 'Wallet',
                  //   icon: FontAwesomeIcons.googleWallet,
                  //   onClicked: () => selectedItem(context, 1),
                  // ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  //const Divider(color: Colors.white70),
                  // const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'My Bookings',
                    icon: FontAwesomeIcons.clockRotateLeft,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  // const SizedBox(height: 16),
                  // buildMenuItem(
                  //   text: 'Pricing Calculator',
                  //   icon: FontAwesomeIcons.calendarCheck,
                  //   onClicked: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const PricingCal(),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Help & Support',
                    icon: FontAwesomeIcons.question,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 40),
                  const Divider(color: Colors.white70),
                  buildMenuItem(
                    text: 'Logout',
                    icon: FontAwesomeIcons.arrowRightFromBracket,
                    onClicked: () => firebaseAuth.signOut().then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signin(),
                          ));
                    }),
                  ),
                  const Divider(color: Colors.white70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    //required String urlImage,
    required String name,
    //  required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person),
                backgroundColor: Colors.deepPurpleAccent,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   email,
                  //   style: const TextStyle(fontSize: 14, color: Colors.white),
                  // ),
                ],
              ),
              const Spacer(),
              // const CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
              // )
            ],
          ),
        ),
      );

  // Widget buildSearchField() {
  //   const color = Colors.white;

  //   return TextField(
  //     style: const TextStyle(color: color),
  //     decoration: InputDecoration(
  //       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //       hintText: 'Search',
  //       hintStyle: const TextStyle(color: color),
  //       prefixIcon: const Icon(Icons.search, color: color),
  //       filled: true,
  //       fillColor: Colors.white12,
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MyAccount(),
        ));
        //   break;
        // case 1:
        //   if (sharedPreferences!.getBool('walletOpen') == true) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const Wallet()),
        //     );
        //   } else {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const WalletActivate()),
        //     );
        //   }
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Settings(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MyBookings(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HelpAndSupport(),
        ));
        break;
    }
  }
}
