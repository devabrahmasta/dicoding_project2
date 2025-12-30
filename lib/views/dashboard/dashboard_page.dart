import 'package:carousel_slider/carousel_slider.dart';
import 'package:dicoding_project2/models/movie.dart';
import 'package:dicoding_project2/views/dashboard/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_project2/data/movie_data.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentPage = 0;

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
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.grey.shade400,
                  ),
                ),
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
                    backgroundColor: Theme.of(context).colorScheme.surface,
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
            // SliverToBoxAdapter(child: _space(20)),
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
                    hintText: 'Cari Film..',
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

            // title
            SliverToBoxAdapter(child: _space(20)),
            _title('Sedang Tayang'),

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
                            nowShowingMovies[_currentPage].title,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Carousel
                  CarouselSlider.builder(
                    itemCount: nowShowingMovies.length,
                    itemBuilder: (context, index, realIndex) {
                      final movie = nowShowingMovies[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Movie movieData = nowShowingMovies[index];
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: DetailPage(movie: movieData),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    movie.image,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                top: 12,
                                child: _rating(
                                  movie.rating,
                                  Theme.of(context).colorScheme.secondary,
                                  Colors.white,
                                ),
                              ),

                              if (index == _currentPage)
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 100),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    curve: Curves.fastOutSlowIn,
                                    height: 50,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                          ),
                        ),
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
                final movie = nowShowingMovies[index];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 40,
                        child: Text(
                          (index + 1).toString().padLeft(2, '0'),
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 32,
                              ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            movie.image,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _badge(movie.usia),
                            _space(5),
                            Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            _space(5),
                            Text(
                              movie.genre,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: nowShowingMovies.length),
            ),

            SliverToBoxAdapter(child: _space(25)),
            _title('Akan Datang'),

            SliverToBoxAdapter(child: _space(20)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 340,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: nowShowingMovies.length,
                  itemBuilder: (context, index) {
                    final movie = comingSoonMovies[index];

                    return Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: SizedBox(
                        height: 340,
                        width: 180,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                // Image
                                SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      movie.image,
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                ),

                                // Age
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: _badge(movie.usia, isFill: true),
                                ),
                              ],
                            ),

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                    // _space(5),
                                    // Text(
                                    //   movie.genre,
                                    //   style: Theme.of(
                                    //     context,
                                    //   ).textTheme.labelSmall,
                                    //   maxLines: 2,
                                    //   overflow: TextOverflow.ellipsis,
                                    // ),
                                    // _space(5),
                                    // Row(
                                    //   children: [
                                    //     _badge(movie.usia),
                                    //     SizedBox(width: 5),
                                    //     // Text(
                                    //     // movie.title, style:
                                    //     //   Theme.of(
                                    //     //     context,
                                    //     //   ).colorScheme.secondary,
                                    //     //   Colors.white,
                                    //     // ),),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _space(double height) {
    return SizedBox(height: height);
  }

  Widget _badge(String usia, {bool isFill = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isFill == true
            ? Theme.of(context).colorScheme.secondary
            : Colors.transparent,
        border: isFill == true
            ? null
            : Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        usia,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w900,
          color: isFill == true
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _title(String title) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }

  Widget _rating(double rating, Color backgroundColor, Color foregroundColor) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 25,
      width: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.star, color: foregroundColor, size: 12),
          SizedBox(width: 2),
          Text('4.5', style: TextStyle(color: foregroundColor, fontSize: 12)),
        ],
      ),
    );
  }

  // Widget _buildDot(int index) {
  //   return AnimatedContainer(
  //     duration: Duration(milliseconds: 200),
  //     margin: EdgeInsets.only(right: 5),
  //     height: 6,
  //     width: _currentPage == index ? 25 : 6,
  //     curve: Curves.easeIn,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(30),
  //       color: _currentPage == index
  //           ? Theme.of(context).colorScheme.primary
  //           : Colors.grey,
  //     ),
  //   );
  // }
}
