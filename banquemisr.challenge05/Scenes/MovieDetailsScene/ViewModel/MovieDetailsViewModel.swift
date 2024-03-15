//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation
import Combine

final class MovieDetailsViewModel {
    private let repo: MovieDetailsRepoType
    private var router: MovieDetailsRouterProtocol?
    private var movieID: Int
    private var moviesDetails = PassthroughSubject<MovieDetailsEntity, Never>()
    init(repo: MovieDetailsRepoType, router: MovieDetailsRouterProtocol, movieID: Int) {
        self.repo = repo
        self.router = router
        self.movieID = movieID
    }
}

extension MovieDetailsViewModel: MovieDetailsViewModelInput {
    func viewDidLoad() {
        Task {
            do {
                let movieDetailsResponse = try await repo.getMovieDetails(id: movieID)
                moviesDetails.send(movieDetailsResponse)
            } catch let error {
                print(error)
            }
        }
    }
}

extension MovieDetailsViewModel: MovieDetailsViewModelOutput {
    var movieDetailsPublisher: AnyPublisher<MovieDetailsEntity, Never> {
        moviesDetails.eraseToAnyPublisher()
    }
}

