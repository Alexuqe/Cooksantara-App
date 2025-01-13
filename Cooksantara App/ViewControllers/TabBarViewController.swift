    //
    //  TabBarViewController.swift
    //  Cooksantara App
    //
    //  Created by Sasha on 12.01.25.
    //

import UIKit

final class TabBarViewController: UITabBarController {

        //MARK: Private Outlets
    private let homeVC = HomeViewController()
    private let searchVC = SearchViewController()
    private let favouritesVC = FavouritesViewController()
    private let profileVC = ProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        apperanceTabBar()
        setupTabBarController()
    }

        //MARK: Private Methods
    private func apperanceTabBar() {
        let apperance = UITabBarAppearance()
        apperance.backgroundColor = .white
        apperance.configureWithOpaqueBackground()


        tabBar.standardAppearance = apperance
        tabBar.scrollEdgeAppearance = apperance
    }

    private func setupTabBarController() {

        let homeNavigationController = addNavigationController(with: homeVC)
        let searchNavigationController = addNavigationController(with: searchVC)
        let favouritesNavigationController = addNavigationController(with: favouritesVC)
        let profileNavigationController = addNavigationController(with: profileVC)

        homeNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: .hauseTabBar.withRenderingMode(.alwaysOriginal),
            selectedImage: .hauseHilited.withRenderingMode(.alwaysOriginal)
        )
        searchNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: .searchTabBar.withRenderingMode(.alwaysOriginal),
            selectedImage: .searchHilited.withRenderingMode(.alwaysOriginal)
        )
        favouritesNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: .favouriteTabBar.withRenderingMode(.alwaysOriginal),
            selectedImage: .favouriteHilited.withRenderingMode(.alwaysOriginal)
        )
        profileNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: .profileTabBar.withRenderingMode(.alwaysOriginal),
            selectedImage: .profileHilited.withRenderingMode(.alwaysOriginal)
        )

        let tabBar = [homeNavigationController, searchNavigationController, favouritesNavigationController, profileNavigationController]
        setViewControllers(tabBar, animated: true)
    }

        //MARK: UI Helper
    private func addNavigationController(with rootController: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: rootController)
    }

}
