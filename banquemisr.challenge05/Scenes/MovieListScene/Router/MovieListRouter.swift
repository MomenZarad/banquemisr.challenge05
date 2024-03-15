//
//  MovieListRouter.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import UIKit

protocol MovieListRouterProtocol {
    
}

final class MovieListRouter: MovieListRouterProtocol {
    weak var controller: UIViewController?

    static func createRepositoriesList(type: MovieType) -> UIViewController {
        let repo = movieListRepo()
        let router = MovieListRouter()
        let viewModel = MovieListViewModel(repo: repo, router: router)
        let viewController = MovieListViewController(viewModel: viewModel, type: type)
        router.controller = viewController
        return viewController
    }
}
