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
        let movieDetailsEntity = response.mapMovieDetailsEntity()
        CoreDataHandler.shared.insertMovieDetails(with: id, details: movieDetailsEntity)
        return movieDetailsEntity
    }
    
    func getStoredMovieDetails(id: Int) -> MovieDetailsEntity? {
        let movieDetails = CoreDataHandler.shared.fetchMovieDetails(with: id)
        guard let title = movieDetails.first?.value(forKey: "title") as? String,
              let releaseDate = movieDetails.first?.value(forKey: "releaseDate") as? String,
              let posterImage = movieDetails.first?.value(forKey: "posterImage") as? String,
              let genre = movieDetails.first?.value(forKey: "genre") as? String,
              let overview = movieDetails.first?.value(forKey: "overview") as? String,
              let runtime = movieDetails.first?.value(forKey: "runtime") as? Int else { return nil }
        return MovieDetailsEntity(movieTitle: title,
                                  movieReleaseDate: releaseDate,
                                  moviePosterImage: posterImage,
                                  movieGenres: genre,
                                  movieOverview: overview,
                                  movieRunTime: runtime)
    }
}
