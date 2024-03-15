//
//  MovieDetailsRepo.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

final class MovieDetailsRepo {
    func convertToMovieDetailsEntity(model: Movies) -> MovieDetailsEntity {
        return MovieDetailsEntity(movieTitle: model.title ?? "",
                                  movieReleaseDate: model.releaseDate ?? "",
                                  moviePosterImage: model.posterPath ?? "",
                                  movieGenres: model.genres?.map({$0.name ?? ""}).joined(separator: ", ") ?? "",
                                  movieOverview: model.overview ?? "",
                                  movieRunTime: model.runtime ?? 0)
    }
}

extension MovieDetailsRepo: MovieDetailsRepoType {
    func getMovieDetails(id: Int) async throws -> MovieDetailsEntity {
        let response = try await NetworkClient.performRequest(model: Movies.self, router: .movieDetails(id: id))
        return convertToMovieDetailsEntity(model: response)
    }
}
