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
        let movieListEntity = response.mapToMovieListEntity()
        CoreDataHandler.shared.insert(movieListEntity, type: "Upcoming")
        return (movieListEntity, response.totalPages ?? 1)
    }
    
    func getStoredMovieList() -> [MoviesEntity] {
        let movies = CoreDataHandler.shared.fetchAllMovies(with: "Upcoming")
        let list: [MoviesEntity] = movies.compactMap {
            guard let id = $0.value(forKey: "id") as? Int,
                  let title = $0.value(forKey: "title") as? String,
                  let releaseDate = $0.value(forKey: "releaseDate") as? String,
                  let posterImage = $0.value(forKey: "posterImage") as? String else { return nil }
            return MoviesEntity (movieID: id,
                                 movieTitle: title,
                                 movieReleaseDate: releaseDate,
                                 moviePosterImage: posterImage)
        }
        return list
    }
}
