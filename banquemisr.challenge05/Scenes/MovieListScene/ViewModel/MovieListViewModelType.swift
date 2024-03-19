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
    func fetchMovieList()
    func didSelectMovie(at index: Int)
}

protocol MovieListViewModelOutput {
    var movieListPublisher: AnyPublisher<[MoviesEntity], Never> { get }
    var isLoading: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
    func getMoviesCount() -> Int
    func getMoviesItem(at index: Int) -> MoviesEntity
}
