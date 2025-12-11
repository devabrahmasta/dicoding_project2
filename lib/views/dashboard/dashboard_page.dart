import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // final List<String, dynamic> _promoDatabase = [

  // ];
  final List<Map<String, dynamic>> _filmDatabase = [
    {
      'title': 'Inside Out',
      'gendre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'image': 'https://i.ebayimg.com/images/g/wtUAAOSwtqtk4Ytr/s-l1200.jpg',
    },
    {
      'title': 'Demon Slayer: Infinity Castle',
      'gendre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'image': 'https://i.pinimg.com/736x/8e/3e/e4/8e3ee44a61d4e3c3c24725151138c1ef.jpg',
    },
    {
      'title': 'Demon Slayer: Infinity Castle',
      'gendre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'image': 'https://i.pinimg.com/736x/a5/45/45/a545452373f034a31abd0c6398bd3d1d.jpg',
    },
    {
      'title': 'Interstelar',
      'gendre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'image': 'https://tse4.mm.bing.net/th/id/OIP.hm_XUN8Dj75wA2PQ1hwafwHaLH?cb=ucfimg2&ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3',
    },
    {
      'title': 'Zootopia 2',
      'gendre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'image': 'https://hilite.org/wp-content/uploads/2025/12/bjUWGw0Ao0qVWxagN3VCwBJHVo6.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    int _currentPage = 0;

    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: CustomScrollView(
          slivers: [
            // User Profile
            SliverToBoxAdapter(
              child: ListTile(
                leading: CircleAvatar(),
                title: Text(
                  'Welcome Dicoding',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900),
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    Text('Sleman, Yogyakarta'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.notifications, color: Colors.blue),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFEAEFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      // side: BorderSide(width: 0),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ),

            // Carousel
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Sedang Tayang',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: CarouselSlider.builder(
                itemCount: _filmDatabase.length,
                itemBuilder: (context, index, realIndex) {
                  return Stack(
                    children: [
                      if (realIndex == _currentPage)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                            ),
                            child: Text('Beli Ticket'),
                          ),
                        ),

                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(15),
                        ),
                        child: ClipRRect(
                          child: Image.network(
                            _filmDatabase[index]['image'],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, reason) => setState(() {
                    _currentPage = index;
                  }),
                  height: 300,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.5,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            //     
          ],
        ),
      ),
    );
  }
}
