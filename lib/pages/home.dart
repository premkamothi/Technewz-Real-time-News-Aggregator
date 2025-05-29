import 'package:flutter/material.dart';
import 'package:technewz/backend/functions.dart';
import 'package:technewz/components/newsbox.dart';
import 'package:technewz/utils/colors.dart';
import 'package:technewz/utils/constants.dart';
import '../components/appbar.dart';
import '../components/serachbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List> news;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    news = fetchnews(query: ''); // Initial load
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      news = fetchnews(query: Searchbar.searchcontroller.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Searchbar(onSearch: _performSearch),
          Expanded(
            child: Container(
              width: w,
              child: FutureBuilder(
                future: news,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No news available"));
                  }

                  return ListView.builder(
                    physics: ClampingScrollPhysics(), // or BouncingScrollPhysics
                    controller: _scrollController,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final newsItem = snapshot.data![index];
                      return Newsbox(
                        url: newsItem['url'] ?? '',
                        imageurl: newsItem['urlToImage'] ?? Constants.imgurl,  // ✅ Corrected key
                        title: newsItem['title'] ?? 'No title',
                        time: newsItem['publishedAt'] ?? '',
                        description: newsItem['description'] ?? '',
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

