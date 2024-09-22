import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movie_detail_page.dart';
import 'package:movie_app/services/api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ApiServices apiServices = ApiServices();
  TextEditingController _searchController = TextEditingController();
  Future<Result>? searchResults;

  void _searchMovies() {
    setState(() {
      searchResults = apiServices.searchMovies(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoSearchTextField(
                controller:
                    _searchController, // Vincula o controlador ao campo de texto
                padding: const EdgeInsets.all(10.0),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.black),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onSubmitted: (value) {
                  _searchMovies(); // Inicia a busca ao submeter o texto
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: searchResults == null
                  ? const Center(child: Text('Search for a movie'))
                  : FutureBuilder<Result>(
                      future: searchResults,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData &&
                            snapshot.data!.movies.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.movies.length,
                            itemBuilder: (context, index) {
                              final movie = snapshot.data!.movies[index];
                              return ListTile(
                                title: Text(movie.title),
                                leading: Image.network(
                                  '$imageUrl${movie.posterPath}',
                                  fit: BoxFit.cover,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MovieDetailPage(
                                                id: movie.id,
                                              )));
                                },
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text('No movies found.'));
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
