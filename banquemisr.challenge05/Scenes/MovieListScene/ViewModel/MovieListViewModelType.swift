//
//  MovieListViewModelType.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation
import Combine

typealias MovieListViewModelType = MovieListViewModelInput & MovieListViewModelOutput

protocol MovieListViewModelInput {
    func fetchMovieList(type: MovieType)
    func didSelectMovie(at index: Int)
}

protocol MovieListViewModelOutput {
    var movieListPublisher: AnyPublisher<[MoviesEntity], Never> { get }
    func getMoviesCount() -> Int
    func getMoviesItem(at index: Int) -> MoviesEntity
}
