import 'package:fixora/Features/ServiceProvider/Profile/Presentation/Widgets/my_card.dart';
import 'package:flutter/material.dart';

class ProviderProfile extends StatefulWidget {
  const ProviderProfile({super.key});

  @override
  State<ProviderProfile> createState() => _ProviderProfile();
}

class _ProviderProfile extends State<ProviderProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                "Profile",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://plus.unsplash.com/premium_photo-1681943258709-9137146aa2bf?q=80&w=784&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                ),
                radius: 50,
              ),

              SizedBox(height: 30),

              MyCard(text: "Pushp Hans", label: "Name", icon: Icons.person),

              SizedBox(height: 15),

              MyCard(text: "6006581286", label: "Phone no.", icon: Icons.call),

              SizedBox(height: 15),

              MyCard(text: "Jammu", label: "City.", icon: Icons.location_city),

              SizedBox(height: 15),

              MyCard(
                text: "Hi Im Pushp Hans and I am a flutter developer",
                label: "Bio",
                icon: Icons.info,
              ),

              SizedBox(height: 15),

              MyCard(text: "6006581286", label: "Phone no.", icon: Icons.call),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF6B35),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, "/editprofile");
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
