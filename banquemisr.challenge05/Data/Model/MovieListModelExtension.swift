//
//  MovieListModelExtension.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 17/03/2024.
//

import Foundation

extension MoviesModel {
    func mapToMovieListEntity() -> [MoviesEntity] {
         return self.results?.map { model in
            MoviesEntity(movieID: model.id ?? 0,
                         movieTitle: model.title ?? "",
                         movieReleaseDate: model.releaseDate ?? "",
                         moviePosterImage: model.posterPath ?? "")
         } ?? []
    }
}
