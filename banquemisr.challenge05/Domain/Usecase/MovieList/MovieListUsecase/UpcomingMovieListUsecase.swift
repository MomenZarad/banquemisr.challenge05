//
//  UpcomingMovieListUsecase.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 17/03/2024.
//

import Foundation

final class UpcomingMovieListUsecase: MovieListUsecaseType {
    func getMovieList(params: [String : Any]) async throws -> (movies: [MoviesEntity], totalPages: Int) {
        let response = try await NetworkClient.performRequest(model: MoviesModel.self, router: .upcoming(params: params))
        return (response.mapToMovieListEntity(), response.totalPages ?? 1)
    }
}
