//
//  TabbarViewController.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 14/03/2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieTabs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupMovieTabs(){
        let nowPlayingController = setNavigationController(title: "Now Playing", image: UIImage(systemName: "play.tv"),
                                                           MovieListRouter.createNowPlayingMoviesList())
        let popularController = setNavigationController(title: "Popular", image: UIImage(systemName: "star"),
                                                        MovieListRouter.createPopularMoviesList())
        let upcomingController = setNavigationController(title: "Upcoming", image: UIImage(systemName: "sparkles.tv"),
                                                         MovieListRouter.createUpcomingMoviesList())
        self.setViewControllers([nowPlayingController, popularController, upcomingController], animated: true)
    }
}
extension TabBarViewController {
    func setNavigationController(title: String, image: UIImage?, _ viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController.init(rootViewController: viewController)
        nav.viewControllers.first?.navigationItem.title = title
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
