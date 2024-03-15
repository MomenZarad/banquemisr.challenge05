//
//  MovieListUsecase.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

protocol MovieListRepoType {
    func getMovieList(type: MovieType, params: [String: Any]) async throws -> (movies: [MoviesEntity], totalPages: Int)
}
