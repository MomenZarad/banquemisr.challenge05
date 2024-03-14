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
        self.tabBar.barTintColor = .green
    }
    
    func setupMovieTabs(){
        let nowPlayingController = setNavigationController(title: "Now Playing", image: UIImage(systemName: "play.tv"), UIViewController())
        let popularController = setNavigationController(title: "Popular", image: UIImage(systemName: "star"), UIViewController())
        let upcomingController = setNavigationController(title: "Upcoming", image: UIImage(systemName: "sparkles.tv"), UIViewController())
        self.setViewControllers([nowPlayingController, popularController, upcomingController], animated: true)
    }
}
extension TabBarViewController {
    func setNavigationController(title: String, image: UIImage?, _ viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController.init(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
