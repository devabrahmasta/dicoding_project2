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

  final List<Map<String, dynamic>> _filmDatabase = [
    {
      'title': 'Inside Out',
      'genre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'usia': '18+',
      'image': 'https://i.ebayimg.com/images/g/wtUAAOSwtqtk4Ytr/s-l1200.jpg',
    },
    {
      'title': 'Jujutsu Kaisen',
      'genre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'usia': '13+',
      'image':
      'https://i.pinimg.com/736x/8e/3e/e4/8e3ee44a61d4e3c3c24725151138c1ef.jpg',
    },
    {
      'title': 'Demon Slayer: Infinity Castle',
      'genre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'usia': '17+',
      'image':
      'https://i.pinimg.com/736x/a5/45/45/a545452373f034a31abd0c6398bd3d1d.jpg',
    },
    {
      'title': 'Interstelar',
      'genre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'usia': '21+',
      'image':
      'https://tse4.mm.bing.net/th/id/OIP.hm_XUN8Dj75wA2PQ1hwafwHaLH?cb=ucfimg2&ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3',
    },
    {
      'title': 'Zootopia 2',
      'genre': 'Animation, Adventure, Romance',
      'synopsis': 'ajfnkajsdnfajksldnfasd',
      'usia': '13+',
      'image':
      'https://hilite.org/wp-content/uploads/2025/12/bjUWGw0Ao0qVWxagN3VCwBJHVo6.jpg',
    },
  ];

  // ];
  @override
  Widget build(BuildContext context) {
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
                  icon: Icon(
                    Icons.notifications,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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

            // Searchbar
            SliverToBoxAdapter(child: _space(20)),
            SliverAppBar(
              pinned: true,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      enabled: true,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        // isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        hintText: 'Cari Film..',
                        hintStyle: Theme.of(context).textTheme.labelLarge
                            ?.copyWith(
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
              ],
            ),

            // title
            SliverToBoxAdapter(child: _space(20)),
            _title('Now Showing'),

            SliverToBoxAdapter(child: _space(20)),
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  // Background
                  Container(
                    height: 380,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFCCD5DA),
                          const Color(0xFFFFFFFF),
                          const Color(0xFFFFFFFF),
                          const Color(0xFFFFFFFF),
                          const Color(0xFFFFFFFF),
                        ],
                        begin: AlignmentGeometry.bottomCenter,
                        end: AlignmentGeometry.topCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 320),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          child: Text(
                            _filmDatabase[_currentPage]['title'],
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                    // child: Text(_filmDatabase[index]['title']),
                  ),

                  // Carousel
                  CarouselSlider.builder(
                    itemCount: _filmDatabase.length,
                    itemBuilder: (context, index, realIndex) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                _filmDatabase[index]['image'],
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 12,
                            top: 12,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              height: 25,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '4.5',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          if (index == _currentPage)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedContainer(
                                duration: Duration(seconds: 100),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                curve: Curves.fastOutSlowIn,
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.confirmation_number_rounded,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Beli Tiket',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
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
                      initialPage: 3,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),

            // title 2
            SliverToBoxAdapter(child: _space(20)),
            _title('Top Chart'),

            // Top Chart
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final film = _filmDatabase[index];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 40,
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w900, fontSize: 32),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        height: 80,
                        child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(_filmDatabase[index]['image'], fit: BoxFit.fitWidth),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            film['title'],
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                fontWeight: FontWeight.w900,

                            ),
                          ),
                          _space(5),
                          Text(film['genre']),
                          _space(5),
                          Chip(
                            label: Text( film['usia']),
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            padding: EdgeInsets.all(0),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _space(double height) {
    return SizedBox(height: height);
  }

  Widget _title(String title) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      sliver: SliverToBoxAdapter(
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 25 : 6,
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: _currentPage == index
            ? Theme.of(context).colorScheme.primary
            : Colors.grey,
      ),
    );
  }
}
