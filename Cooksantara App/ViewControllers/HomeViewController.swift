    //
    //  HomeViewController.swift
    //  Cooksantara App
    //
    //  Created by Sasha on 12.01.25.
    //

import UIKit

    //MARK: Enums
enum HeadersCollectioView: CaseIterable {
    case trending
    case mealType
    case proTips

    var title: String {
        switch self {
            case .trending: "Trending"
            case .mealType: "Meal Type"
            case .proTips: "Pro Tips"
        }
    }

    var image: UIImage {
        switch self {
            case .trending:
                    .trandin
            case .mealType:
                    .popalrChefHeart
            case .proTips:
                    .icLamp
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var trendingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = HeadersCollectioView.trending.image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var trendingLabel: UILabel = {
        let label = UILabel()
        label.text = HeadersCollectioView.trending.title
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var trendingStackView = createStackView(subviews: viewsOnStack)

    private lazy var trendingCollectionView = createCollectionView()

        //MARK: Properties
    var recipes: [Recipe] = []

        //MARK: Private Properties
    private let networkManager = NetworkManager.shared
    private lazy var viewsOnStack: [UIView] = [trendingImage, trendingLabel]

        //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureNavigationBar()
        setupUI()
        registerCell()
        fetchReceites()
        print(recipes)
    }


}

    //MARK: Private Properties
private extension HomeViewController {

        //MARK: Configure UI
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.black
        ]

        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white

        navigationItem.title = "What do you want cooking today?"
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        let backButton = UIBarButtonItem()
        backButton.tintColor = .systemGray2
        navigationItem.backBarButtonItem = backButton
    }

    func setupUI() {
        addSubviews()
        constraintsSearchBar()
        constraintsScrollView()
        constraintsContentView()
        constraintsTrendingStackView()
        constraintsTrandingCollectionView()
    }

    func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        let viewArray = [trendingStackView, trendingCollectionView]
        viewArray.forEach {contentView.addSubview($0)}
    }

    func registerCell() {
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        trendingCollectionView.register(
            TrendinCollectionViewCell.self,
            forCellWithReuseIdentifier: TrendinCollectionViewCell.identifer)
    }


        //MARK: Constraints
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

    func constraintsTrendingStackView() {
        NSLayoutConstraint.activate([
            trendingStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            trendingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            trendingStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            trendingStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.03)

        ])
    }

    func constraintsTrandingCollectionView() {
        NSLayoutConstraint.activate([
            trendingCollectionView.topAnchor.constraint(equalTo: trendingStackView.bottomAnchor, constant: 5),
            trendingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            trendingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            trendingCollectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)

        ])
    }
}

    //MARK: UI Helper
private extension HomeViewController {

    func createStackView(
        axis: NSLayoutConstraint.Axis = .horizontal,
        spacing: CGFloat = 2,
        distribution: UIStackView.Distribution = .fillProportionally,
        aligment: UIStackView.Alignment = .fill,
        subviews: [UIView]
    ) -> UIStackView {
        {
        let stacView = $0
        stacView.axis = axis
        stacView.spacing = spacing
        stacView.alignment = aligment
        stacView.distribution = distribution
        subviews.forEach { stacView.addArrangedSubview($0) }
        stacView.translatesAutoresizingMaskIntoConstraints = false

        return stacView
        }(UIStackView())
    }

    func createCollectionView(
        scroll: UICollectionView.ScrollDirection = .horizontal,
        sectionInserts: UIEdgeInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8),
        minimumInteritemSpacing: CGFloat = 10,
        minimumLineSpacing: CGFloat = 15
    ) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = sectionInserts
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }


}


    //MARK: Network
private extension HomeViewController {
    func fetchReceites() {
        networkManager.fetch(Recipes.self, from: Links.receipt.url) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let dataReceipt):
                    self.recipes = dataReceipt.recipes
                    trendingCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                    showAlert(with: .failed)
            }
        }
    }
}


//#Preview {
//    let view = HomeViewController()
//    view
//}
