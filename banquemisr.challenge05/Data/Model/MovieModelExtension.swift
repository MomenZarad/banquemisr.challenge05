//
//  MovieModelExtension.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 17/03/2024.
//

import Foundation

extension Movies {
    func mapMovieDetailsEntity() -> MovieDetailsEntity {
        return MovieDetailsEntity(movieTitle: self.title ?? "",
                                  movieReleaseDate: self.releaseDate ?? "",
                                  moviePosterImage: self.posterPath ?? "",
                                  movieGenres: self.genres?.map({$0.name ?? ""}).joined(separator: ", ") ?? "",
                                  movieOverview: self.overview ?? "",
                                  movieRunTime: self.runtime ?? 0)
    }
}
