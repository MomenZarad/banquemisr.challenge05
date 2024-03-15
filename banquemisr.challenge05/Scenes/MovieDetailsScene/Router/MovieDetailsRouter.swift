//
//  MovieDetailsRouter.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import UIKit

protocol MovieDetailsRouterProtocol {
    
}

final class MovieDetailsRouter: MovieDetailsRouterProtocol {
    weak var controller: UIViewController?

    static func createMovieDetails(movieID: Int) -> UIViewController {
        let repo = MovieDetailsRepo()
        let router = MovieDetailsRouter()
        let viewModel = MovieDetailsViewModel(repo: repo, router: router, movieID: movieID)
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        router.controller = viewController
        return viewController
    }
}
