//
//  MockMoviesAPIModel.swift
//  CombineDemo
//
//  Created by João Barbosa on 30/09/2020.
//  Copyright © 2020 Glazed Solutions. All rights reserved.
//

import Combine

struct MockMoviesAPIModel: MoviesAPIModel {
    func getPopularMovies() -> AnyPublisher<MovieList, APIError> {
        return Result<MovieList, APIError>.Publisher(MovieList(results: self.movieArray)).eraseToAnyPublisher()
    }

    func search(query: String) -> AnyPublisher<MovieList, APIError> {
        return Result<MovieList, APIError>.Publisher(MovieList(results: self.movieArray)).eraseToAnyPublisher()
    }

    func getMovieDetail(movieId: Int) -> AnyPublisher<Movie, APIError> {
        return Result<Movie, APIError>.Publisher(Movie(id: 1, title: "Movie_1", overview: "This is movie 1", poster_path: nil,
                                                       vote_average: 3.5, release_date: nil, genre_ids: nil, genres: nil))
            .eraseToAnyPublisher()
    }


    public let movieArray = [Movie(id: 1, title: "Movie_1", overview: "This is movie 1", poster_path: nil,
                            vote_average: 3.5, release_date: nil, genre_ids: nil, genres: nil),
                      Movie(id: 2, title: "Movie_2", overview: "This is movie 2", poster_path: nil,
                            vote_average: 3.5, release_date: nil, genre_ids: nil, genres: nil)]

}
