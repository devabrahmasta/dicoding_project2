import 'package:flutter/material.dart';

class CinemasPage extends StatefulWidget {
  const CinemasPage({super.key});

  @override
  State<CinemasPage> createState() => _CinemasPageState();
}

class _CinemasPageState extends State<CinemasPage> {
  final List<Map<String, dynamic>> _cinemas = [
    {'name': 'Level 21 XXI', 'address': 'Jl. Teuku Umar No.1, Denpasar'},
    {'name': 'Beachwalk XXI', 'address': 'Beachwalk Shopping Center, Kuta'},
    {'name': 'Galeria XXI', 'address': 'Mall Bali Galeria, Kuta'},
    {'name': 'Park 23 XXI', 'address': 'Park 23 Mall, Tuban'},
    {'name': 'Trans Studio Mall XXI', 'address': 'Jl. Imam Bonjol, Denpasar'},
    {'name': 'Cinepolis Plaza Renon', 'address': 'Plaza Renon, Denpasar'},
    {'name': 'Cinepolis Lippo Mall Kuta', 'address': 'Lippo Mall Kuta, Badung'},
    {
      'name': 'Cinepolis Sidewalk Jimbaran',
      'address': 'Sidewalk Jimbaran, Badung',
    },
    {'name': 'Denpasar Cineplex', 'address': 'Jl. M.H. Thamrin, Denpasar'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Daftar Bioskop',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            SliverAppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              pinned: true,
              title: SizedBox(
                height: 45,
                child: TextField(
                  enabled: true,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    hintText: 'Cari Bioskop..',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 8),
                      child: Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final cinema = _cinemas[index];

                return Column(
                  children: [
                    Divider(color: Colors.grey.shade300),
                    ListTile(
                      title: Text(
                        cinema['name'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      subtitle: Text(
                        cinema['address'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 12,
                      ),
                      leading: Icon(Icons.star_rounded, color: Colors.grey),
                    ),
                  ],
                );
              }, childCount: _cinemas.length),
            ),
          ],
        ),
      ),
    );
  }
}
