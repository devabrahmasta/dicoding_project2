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
    {'name': 'Cinepolis Sidewalk Jimbaran', 'address': 'Sidewalk Jimbaran, Badung'},
    {'name': 'Denpasar Cineplex', 'address': 'Jl. M.H. Thamrin, Denpasar'},
  ];

  List<Map<String, dynamic>> _foundCinemas = [];

  @override
  void initState() {
    _foundCinemas = _cinemas;
    super.initState();
  }

  void _runFilter(String enterKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enterKeyword.isEmpty) {
      results = _cinemas;
    } else {
      results = _cinemas
          .where((item) =>
              item["name"].toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundCinemas = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    hintText: 'Cari Bioskop..',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 24, right: 8),
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

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final cinema = _foundCinemas[index];

                return Column(
                  children: [
                    Divider(color: Colors.grey.shade300),
                    ListTile(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Menu bioskop ${cinema['name']} sedang dalam tahap pengembangan'),
                            duration: const Duration(seconds: 1),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
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
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 12,
                      ),
                      leading: const Icon(Icons.star_rounded, color: Colors.grey),
                    ),
                  ],
                );
              }, childCount: _foundCinemas.length),
            ),
            
            if (_foundCinemas.isEmpty) 
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      'Bioskop tidak ditemukan',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}