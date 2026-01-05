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
  bool _isSearching = false;
  List<Movie> _searchResults = [];

  void _runFilter(String enterKeyword) {
    if (enterKeyword.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
    } else {
      final allMovies = [...nowShowingMovies, ...comingSoonMovies];
      final results = allMovies
          .where(
            (movie) =>
                movie.title.toLowerCase().contains(enterKeyword.toLowerCase()),
          )
          .toList();

      setState(() {
        _isSearching = true;
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: CustomScrollView(
          slivers: [
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
                subtitle: const Row(
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
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tidak ada notifikasi baru'),
                      ),
                    );
                  },
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
                    hintText: 'Cari Film..',
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

            if (_isSearching) ...[
              SliverPadding(
                padding: const EdgeInsets.only(top: 20),
                sliver: _searchResults.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                              Icon(
                                Icons.search_off,
                                size: 60,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Film tidak ditemukan',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final movie = _searchResults[index];
                          return _buildSearchResultItem(context, movie);
                        }, childCount: _searchResults.length),
                      ),
              ),
            ] else ...[
              // Title Sedang Tayang
              SliverToBoxAdapter(child: _space(20)),
              _title('Sedang Tayang'),

              // Carousel
              SliverToBoxAdapter(child: _space(20)),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    // Background Gradient
                    Container(
                      height: 450,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFCCD5DA),
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                          ],
                          begin: AlignmentGeometry.bottomCenter,
                          end: AlignmentGeometry.topCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 400),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeOut,
                              child: Text(
                                nowShowingMovies[_currentPage].title,
                                key: ValueKey<String>(
                                  nowShowingMovies[_currentPage].title,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Carousel Slider
                    CarouselSlider.builder(
                      itemCount: nowShowingMovies.length,
                      itemBuilder: (context, index, realIndex) {
                        final movie = nowShowingMovies[index];
                        bool isActive = index == _currentPage;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: DetailPage(movie: movie),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: isActive
                                              ? const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                )
                                              : BorderRadius.circular(15),
                                          child: Image.network(
                                            movie.image,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.grey.shade200,
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 12,
                                        top: 12,
                                        child: _rating(
                                          movie.rating,
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isActive) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    height: 50,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.confirmation_number_rounded,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Beli Tiket',
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
                                ] else ...[
                                  const SizedBox(height: 50),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) => setState(() {
                          _currentPage = index;
                        }),
                        
                        height: 380,
                        aspectRatio: 2/3,
                        viewportFraction: 0.5, 
                        initialPage: 3,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              // Title Top Chart
              SliverToBoxAdapter(child: _space(20)),
              _title('Top Chart'),

              // Top Chart List
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final movie = nowShowingMovies[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
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
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              movie.image,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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

              // Title Coming SOon
              SliverToBoxAdapter(child: _space(25)),
              _title('Akan Datang'),

              // Horizontal List Coming Soon
              SliverToBoxAdapter(child: _space(20)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 340,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: comingSoonMovies.length,
                    itemBuilder: (context, index) {
                      final movie = comingSoonMovies[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SizedBox(
                          height: 340,
                          width: 180,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 250,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        movie.image,
                                        fit: BoxFit.fitWidth,
                                        alignment: Alignment.topCenter,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  color: Colors.grey.shade200,
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: _badge(movie.usia, isFill: true),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
              SliverToBoxAdapter(child: _space(50)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultItem(BuildContext context, Movie movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: DetailPage(movie: movie),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Poster
            SizedBox(
              width: 100,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  movie.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.broken_image,
                        size: 30,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Info Movie
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  _badge(movie.usia),
                  _space(8),
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  _space(5),
                  Text(
                    movie.genre,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _space(8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFBF65),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.rating > 0 ? movie.rating : "-"}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }

  Widget _rating(double rating, Color backgroundColor, Color foregroundColor) {
    return Container(
      padding: const EdgeInsets.all(2),
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
          const SizedBox(width: 2),
          Text('4.5', style: TextStyle(color: foregroundColor, fontSize: 12)),
        ],
      ),
    );
  }
}
