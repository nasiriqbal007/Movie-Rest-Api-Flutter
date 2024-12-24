import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/media_provider.dart';
import 'package:movie_app/View_Model/providers/page_provider.dart';
import 'package:movie_app/pages/mediapage.dart';
import 'package:movie_app/pages/movie_page.dart';
import 'package:movie_app/pages/tv_show_page.dart';
import 'package:movie_app/widgets/media_list_tile.dart';
import 'package:movie_app/widgets/searh_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSearchActive = context.select<MediaProvider, bool>(
      (mediaProvider) => mediaProvider.isSearchActive,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Flutter Cinema",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              MediaSearchBar(
                controller: controller,
                mediaProvider: context.watch<MediaProvider>(),
              ),
              ButtonRow(pageController: pageController),
              Expanded(
                child: PageViewWidget(pageController: pageController),
              ),
            ],
          ),
          if (isSearchActive)
            MediaListTile(
              mediaProvider: context.read<MediaProvider>(),
            ),
        ],
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final currentPage = context.select<PageProvider, int>(
      (pageProvider) => pageProvider.currentPage,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 20),
          for (int i = 0; i < 3; i++)
            CustomButton(
              btnTitle: ["All", "Movies", "TV Shows"][i],
              isSelected: currentPage == i,
              onTap: () {
                context.read<PageProvider>().updatePage(i);
                pageController.jumpToPage(i);
              },
            ),
        ],
      ),
    );
  }
}

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, provider, _) {
        return PageView(
          controller: pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: provider.updatePage,
          children: const [
            AllMediaPage(),
            MoviePage(),
            TvShowPage(),
          ],
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  final String btnTitle;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.btnTitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.yellow.shade700
              : Colors.grey.shade600.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            btnTitle,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 2,
              color: isSelected ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
