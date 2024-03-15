//
//  MovieListRouter.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import UIKit

protocol MovieListRouterProtocol {
    func navigateToMovieDetails(movieID: Int)
}

final class MovieListRouter: MovieListRouterProtocol {
    weak var controller: UIViewController?

    static func createMoviesList(type: MovieType) -> UIViewController {
        let repo = movieListRepo()
        let router = MovieListRouter()
        let viewModel = MovieListViewModel(repo: repo, router: router)
        let viewController = MovieListViewController(viewModel: viewModel, type: type)
        router.controller = viewController
        return viewController
    }
    
    func navigateToMovieDetails(movieID: Int) {
        let detailsViewController = MovieDetailsRouter.createMovieDetails(movieID: movieID)
        controller?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
