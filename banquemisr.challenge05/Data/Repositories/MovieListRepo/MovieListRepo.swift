//
//  MovieListRepo.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

final class movieListRepo {
    func convertToMovieEntity(model: [Movies]) -> [MoviesEntity] {
        return model.map { model in
            MoviesEntity(movieID: model.id ?? 0,
                         movieTitle: model.title ?? "",
                         movieReleaseDate: model.releaseDate ?? "",
                         moviePosterImage: model.posterPath ?? "")
        }
    }
}

extension movieListRepo: MovieListRepoType {
    func getMovieList(type: MovieType, params: [String: Any]) async throws -> (movies: [MoviesEntity], totalPages: Int) {
        switch type {
        case .nowPlaying:
            let response = try await NetworkClient.performRequest(model: MoviesModel.self, router: .nowPlaying(params: params))
            return (convertToMovieEntity(model: response.results ?? []), response.totalPages ?? 1)
        case .popular:
            let response = try await NetworkClient.performRequest(model: MoviesModel.self, router: .popular(params: params))
            return (convertToMovieEntity(model: response.results ?? []), response.totalPages ?? 1)
        case .upcoming:
            let response = try await NetworkClient.performRequest(model: MoviesModel.self, router: .upcoming(params: params))
            return (convertToMovieEntity(model: response.results ?? []), response.totalPages ?? 1)
        }
    }
}
