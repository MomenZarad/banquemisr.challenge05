//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation
import Combine

final class MovieDetailsViewModel {
    private let usecase: MovieDetailsUsecase
    private var router: MovieDetailsRouterProtocol?
    private var movieID: Int
    private var moviesDetails = PassthroughSubject<MovieDetailsEntity, Never>()
    init(usecase: MovieDetailsUsecase, router: MovieDetailsRouterProtocol, movieID: Int) {
        self.usecase = usecase
        self.router = router
        self.movieID = movieID
    }
}

extension MovieDetailsViewModel: MovieDetailsViewModelInput {
    func viewDidLoad() {
        Task {
            do {
                let movieDetailsResponse = try await usecase.getMovieDetails(id: movieID)
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

