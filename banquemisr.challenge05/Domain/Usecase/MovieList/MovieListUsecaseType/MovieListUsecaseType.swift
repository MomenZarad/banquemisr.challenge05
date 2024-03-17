//
//  MovieListUsecaseType.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 17/03/2024.
//

import Foundation

protocol MovieListUsecaseType {
    func getMovieList(params: [String: Any]) async throws -> (movies: [MoviesEntity], totalPages: Int)
    func getStoredMovieList() -> [MoviesEntity]
}
