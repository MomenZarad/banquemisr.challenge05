//
//  MovieDetailsUsecase.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

final class MovieDetailsUsecase: MovieDetailsUsecaseType {
    func getMovieDetails(id: Int) async throws -> MovieDetailsEntity {
        let response = try await NetworkClient.performRequest(model: Movies.self, router: .movieDetails(id: id))
        return response.mapMovieDetailsEntity()
    }
}
