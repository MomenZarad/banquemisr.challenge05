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
    
    static func createNowPlayingMoviesList() -> UIViewController {
        let usecase = NowPlayingMovieListUsecase()
        let router = MovieListRouter()
        let viewModel = MovieListViewModel(usecase: usecase, router: router)
        let viewController = MovieListViewController(viewModel: viewModel)
        router.controller = viewController
        return viewController
    }
    
    static func createPopularMoviesList() -> UIViewController {
        let usecase = PopularMovieListUsecase()
        let router = MovieListRouter()
        let viewModel = MovieListViewModel(usecase: usecase, router: router)
        let viewController = MovieListViewController(viewModel: viewModel)
        router.controller = viewController
        return viewController
    }
    
    static func createUpcomingMoviesList() -> UIViewController {
        let usecase = UpcomingMovieListUsecase()
        let router = MovieListRouter()
        let viewModel = MovieListViewModel(usecase: usecase, router: router)
        let viewController = MovieListViewController(viewModel: viewModel)
        router.controller = viewController
        return viewController
    }
    
    func navigateToMovieDetails(movieID: Int) {
        let detailsViewController = MovieDetailsRouter.createMovieDetails(movieID: movieID)
        controller?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
