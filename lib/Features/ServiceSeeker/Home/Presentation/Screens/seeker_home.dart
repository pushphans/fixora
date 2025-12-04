// import 'package:flutter/material.dart';

// class SeekerHome extends StatefulWidget {
//   const SeekerHome({super.key});

//   @override
//   State<SeekerHome> createState() => _SeekerHomeState();
// }

// class _SeekerHomeState extends State<SeekerHome> {
//   final TextEditingController searchController = TextEditingController();

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFFF6B35), Color(0xFFFFB84D)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           'Hello, User! 👋',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'Find the best services near you',
//                           style: TextStyle(fontSize: 14, color: Colors.white70),
//                         ),
//                       ],
//                     ),

//                     IconButton(
//                       onPressed: () async {
//                         await Provider.of<AuthProvider>(
//                           context,
//                           listen: false,
//                         ).logout();

//                         if (!mounted) return;

//                         if (Provider.of<AuthProvider>(
//                               context,
//                               listen: false,
//                             ).isLoggedOutTrue ==
//                             true) {
//                           Navigator.pushNamedAndRemoveUntil(
//                             context,
//                             '/login',
//                             (route) => false,
//                           );

//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               backgroundColor: Colors.green,
//                               behavior: SnackBarBehavior.floating,
//                               content: Text("Logged out successfully"),
//                             ),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               backgroundColor: Colors.red,
//                               behavior: SnackBarBehavior.floating,
//                               content: Text("Unable to log out"),
//                             ),
//                           );
//                         }
//                       },
//                       icon: Icon(Icons.logout),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // Search Bar
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: TextField(
//                     controller: searchController,
//                     decoration: InputDecoration(
//                       hintText: 'Search for services...',
//                       prefixIcon: const Icon(
//                         Icons.search,
//                         color: Color(0xFF8D8D8D),
//                       ),
//                       suffixIcon: Container(
//                         margin: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFFF6B35),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: IconButton(
//                           icon: const Icon(
//                             Icons.tune,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                           onPressed: () {
//                             // Handle filter
//                           },
//                         ),
//                       ),
//                       border: InputBorder.none,
//                       contentPadding: const EdgeInsets.symmetric(vertical: 20),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 15),

//           // Categories Section
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Explore Categories',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF2D3142),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // View all categories
//                   },
//                   child: const Text(
//                     'See All',
//                     style: TextStyle(
//                       color: Color(0xFFFF6B35),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 12),

//           // Categories Grid
//           SizedBox(height: 200, width: double.infinity),

//           const SizedBox(height: 24),

//           // Featured Services Section
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Featured Near You',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF2D3142),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // View all featured
//                   },
//                   child: const Text(
//                     'See All',
//                     style: TextStyle(
//                       color: Color(0xFFFF6B35),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 12),

//           // Featured Services List
//           SizedBox(height: 280),

//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
// }
