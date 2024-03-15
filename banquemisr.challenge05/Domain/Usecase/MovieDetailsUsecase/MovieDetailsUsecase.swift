//
//  MovieDetailsUsecase.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

protocol MovieDetailsRepoType {
    func getMovieDetails(id: Int) async throws -> MovieDetailsEntity
}
