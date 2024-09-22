import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final ApiServices apiServices = ApiServices();
  late Future<MovieDetail> movieDetail;
  late Future<Result> similarMovies;

  @override
  void initState() {
    movieDetail = apiServices.fetchMovieDetails(widget.id);
    similarMovies = apiServices.fetchSimilarMovies(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetail>(
      future: movieDetail,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          final movie = snapshot.data!;

          return Scaffold(
            appBar: AppBar(title: Text(movie.title)),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        movie.posterPath != null
                            ? '$imageUrl${movie.posterPath}'
                            : 'https://via.placeholder.com/500x750.png?text=No+Image',
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 250,
                            width: double.infinity,
                            color: Colors.grey,
                            child: const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      ),
                      Container(
                        height: 250,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black54, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 16,
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sinopse:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.overview.isNotEmpty
                              ? movie.overview
                              : 'Sinopse não disponível.',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Informações:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ano de Lançamento: ${movie.releaseDate.split('-')[0]}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Gêneros: ${movie.genres.map((g) => g.name).join(', ')}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Avaliação: ${movie.voteAverage}/10',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Duração: ${movie.runtime} min',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Orçamento: \$${movie.budget}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Receita: \$${movie.revenue}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Produzido por:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...movie.productionCompanies
                            .map(
                              (company) => Text(
                                company.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      'Filmes Similares',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<Result>(
                    future: similarMovies,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Erro ao carregar filmes similares'));
                      }
                      if (snapshot.hasData &&
                          snapshot.data!.movies.isNotEmpty) {
                        return Container( 
                          height: 250, 
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.movies.length,
                            itemBuilder: (context, index) {
                              final similarMovie = snapshot.data!.movies[index];
                              final posterUrl = similarMovie.posterPath != null
                                  ? '$imageUrl${similarMovie.posterPath}'
                                  : 'https://via.placeholder.com/500x750.png?text=No+Image';

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetailPage(id: similarMovie.id),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 120,
                                  margin: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          posterUrl,
                                          height: 150,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              height: 150,
                                              width: 120,
                                              color: Colors.grey,
                                              child: const Icon(Icons.error, color: Colors.red),
                                            );
                                          },
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                        (loadingProgress.expectedTotalBytes ?? 1)
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        similarMovie.title,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const Center(
                          child: Text('Nenhum filme similar encontrado.'));
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: Text('Nenhum dado encontrado'));
      },
    );
  }
}