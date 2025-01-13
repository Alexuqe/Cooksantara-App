    //
    //  HomeViewController.swift
    //  Cooksantara App
    //
    //  Created by Sasha on 12.01.25.
    //

import UIKit

enum HeadersCollectioView: CaseIterable {
    case trending
    case popularChef
    case proTips

    var title: String {
        switch self {
            case .trending: "Trending"
            case .popularChef: "Popular Chef"
            case .proTips: "Pro Tips"
        }
    }
}

enum Alert {
    case success
    case failed

    var title: String {
        switch self {
            case .success:
                "Success"
            case .failed:
                "Failed"
        }
    }

    var message: String {
        switch self {
            case .success:
                "Complete"
            case .failed:
                "Can see error in debug area"
        }
    }
}

final class HomeViewController: UIViewController {

    //MARK: Private Outlets
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search recipe"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 15

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .green
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureNavigationBar()
        updateUI()
    }


    //MARK: Private Properties
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 25, weight: .bold),
            .foregroundColor: UIColor.black,
        ]

        appearance.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.largeTitleDisplayMode = .always
    }


}

//MARK: Configure UI
private extension HomeViewController {

    func updateUI() {
        addSubviews()

        constraintsSearchBar()
        constraintsScrollView()
        constraintsContentView()
        constraintsTrandingCollectionView()
    }

    func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        let viewArray = [trendingCollectionView]
        viewArray.forEach {contentView.addSubview($0)}
    }



    func constraintsSearchBar() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func constraintsScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 17),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func constraintsContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    func constraintsTrandingCollectionView() {
        NSLayoutConstraint.activate([
            trendingCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            trendingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            trendingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            trendingCollectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4)

        ])
    }





}


#Preview {
    let view = HomeViewController()
    view
}
