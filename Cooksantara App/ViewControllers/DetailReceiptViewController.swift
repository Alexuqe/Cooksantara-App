//
//  DetailReceiptViewController.swift
//  Cooksantara App
//
//  Created by Sasha on 16.01.25.
//

import UIKit

final class DetailReceiptViewController: UIViewController {

    //MARK: Private Outlets
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dishImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let activituIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.layer.cornerRadius = 50
        indicator.contentMode = .scaleAspectFill
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var ratingDishLabel = addLabel()
    private lazy var minutesLabel = addLabel()
    private  lazy var difficultyLabel = addLabel()
    private lazy var labelStackView = createStackView(subviews: views)
    private lazy var segmentedUIView = UIView()
    private lazy var segmentedController = UISegmentedControl()
    private lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        ingredientsLabel.textColor = UIColor.systemGray
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.minimumScaleFactor = 0.9
        ingredientsLabel.textAlignment = .left
        ingredientsLabel.setContentHuggingPriority(.required, for: .vertical)
        ingredientsLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        ingredientsLabel.adjustsFontForContentSizeCategory = true
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()



//MARK: Properties
    var recipes: Recipe?

    //MARK: Private Propeties
    private lazy var views: [UIView] = [ratingDishLabel, minutesLabel, difficultyLabel]
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        scrollView.delegate = self
        setupUI()
        updateUI()
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentedUIView.layoutIfNeeded()
        segmentedUIView.layer.cornerRadius = segmentedUIView.frame.height / 2
    }

}

private extension DetailReceiptViewController {

    //MARK: Update UI
    func updateUI() {
        fetchDishImage()
        ratingDishLabel.text = "★ \(recipes?.rating ?? 0)"
        minutesLabel.text = "⏱︎ \(recipes?.cookTimeMinutes ?? 0) Min"
        difficultyLabel.text = recipes?.difficulty ?? "easy"
        ingredientsLabel.text = separatorIngredientsLabel(recipes?.ingredients ?? ["asdasdasdasdasdasdasdasdasdasdasdasdasdasdasd"])
        print(ingredientsLabel.text!)

    }

    func fetchDishImage() {
        let imageURL = URL(string: recipes?.image ?? "")
        guard let imageURL else {
            print("Invalid image URL: \(recipes?.image ?? "")")
            return
        }

        networkManager.fetch(from: imageURL) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let imageData):
                        self.dishImage.image = UIImage(data: imageData)
                        self.activituIndicator.stopAnimating()
                    case .failure(let error):
                        print(error)
                        self.activituIndicator.stopAnimating()
                }
            }
        }
    }

    func separatorIngredientsLabel(_ ingrediets: [String]) -> String {
        return ingrediets.map { "•  \($0)" }.joined(separator: "\n \n")
    }

    //MARK: Configure UI
    func setupUI() {
        addSubviews()
        constraintsScrollView()
        constraintsContentView()
        constraintsDishImage()
        constraintsActivityIndicator()
        constraintsStackView()
        constraintsContainerSegmentoController()
        constraintsSegmentedCotroller()
        constraintsIngredientsLabel()
        activituIndicator.startAnimating()
    }

    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        configureSegmentoController()
        configureContainerSegmentoController()

        let viewArray = [dishImage, activituIndicator, labelStackView, segmentedUIView, ingredientsLabel]
        viewArray.forEach {contentView.addSubview($0)}

    }

    func configureContainerSegmentoController() {
        segmentedUIView.clipsToBounds = true
        segmentedUIView.translatesAutoresizingMaskIntoConstraints = false
        segmentedUIView.addSubview(segmentedController)
    }

    func configureSegmentoController() {
        segmentedController = UISegmentedControl(items: ["Ingredients", "Directions"])

        segmentedController.selectedSegmentIndex = 0
        segmentedController.selectedSegmentTintColor = .black
        segmentedController.backgroundColor = .white
        segmentedController.clipsToBounds = true
        segmentedController.layer.masksToBounds = true
        segmentedController.layer.cornerRadius = 40

        segmentedController.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedController.setTitleTextAttributes([.foregroundColor: UIColor.systemGray], for: .normal)
        segmentedController.translatesAutoresizingMaskIntoConstraints = false

        segmentedController.addTarget(self, action: #selector(tapSegmentedController), for: .valueChanged)
    }







    //MARK: Action
    @objc func tapSegmentedController(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                return print("0")
            case 1:
                return print("1")
            default:
                break
        }
    }

//MARK: Constraints

    func constraintsScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    func constraintsDishImage() {
        NSLayoutConstraint.activate([
            dishImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dishImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dishImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dishImage.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.45)
        ])
    }

    func constraintsActivityIndicator() {
        NSLayoutConstraint.activate([
            activituIndicator.leadingAnchor.constraint(equalTo: dishImage.leadingAnchor),
            activituIndicator.trailingAnchor.constraint(equalTo: dishImage.trailingAnchor),
            activituIndicator.topAnchor.constraint(equalTo: dishImage.topAnchor),
            activituIndicator.bottomAnchor.constraint(equalTo: dishImage.bottomAnchor)
        ])
    }

    func constraintsStackView() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: dishImage.bottomAnchor, constant: 10),
            labelStackView.leadingAnchor.constraint(equalTo: dishImage.leadingAnchor, constant: 5),
            labelStackView.trailingAnchor.constraint(equalTo: dishImage.trailingAnchor, constant: -5)
        ])
    }

    func constraintsContainerSegmentoController() {
        NSLayoutConstraint.activate([
            segmentedUIView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 10),
            segmentedUIView.leadingAnchor.constraint(equalTo: dishImage.leadingAnchor),
            segmentedUIView.trailingAnchor.constraint(equalTo: dishImage.trailingAnchor),
            segmentedUIView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    func constraintsSegmentedCotroller() {
        NSLayoutConstraint.activate([
            segmentedController.topAnchor.constraint(equalTo: segmentedUIView.topAnchor, constant: -5),
            segmentedController.leadingAnchor.constraint(equalTo: segmentedUIView.leadingAnchor, constant: -5),
            segmentedController.trailingAnchor.constraint(equalTo: segmentedUIView.trailingAnchor, constant: 5),
            segmentedController.bottomAnchor.constraint(equalTo: segmentedUIView.bottomAnchor, constant: 5)
        ])
    }

    func constraintsIngredientsLabel() {
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: segmentedUIView.bottomAnchor, constant: 20),
            ingredientsLabel.leadingAnchor.constraint(equalTo: segmentedUIView.leadingAnchor, constant: 5),
            ingredientsLabel.trailingAnchor.constraint(equalTo: segmentedUIView.trailingAnchor, constant: -5),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -90)
        ])
    }
}


private extension DetailReceiptViewController {

        //MARK: UI Helper
    func addLabel(
        font: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular),
        textColor: UIColor = .systemGray,
        textAlignment: NSTextAlignment = .left,
        minimumScaleFactor: CGFloat = 0.9
    ) -> UILabel {
        {
        $0.font = font
        $0.text = " asdasdasdasd "
        $0.textColor = textColor
        $0.textAlignment = .left
        $0.baselineAdjustment = .alignBaselines
        $0.minimumScaleFactor = 0.9
        $0.adjustsFontForContentSizeCategory = true
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
        }(UILabel())
    }

    func createStackView(
        axis: NSLayoutConstraint.Axis = .horizontal,
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .equalCentering,
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

}

extension DetailReceiptViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let dishImageHeight = dishImage.frame.height

        if offsetY > 0 { // Прокрутка вниз
            let scale = max(1 - offsetY / dishImageHeight, 0.8)
            dishImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        } else {
            dishImage.transform = .identity
            labelStackView.transform = .identity
        }
    }
}

#Preview {
    let view = DetailReceiptViewController()
    view
}
