//
//  DetailReceiptViewController.swift
//  Cooksantara App
//
//  Created by Sasha on 16.01.25.
//

import UIKit

final class DetailReceiptViewController: UIViewController {

    //MARK: Outlets
    var dishImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    lazy var ratingDishLabel = addLabel()
    lazy var minutesLabel = addLabel()
    lazy var difficultyLabel = addLabel()

    //MARK: Private Outlets
    private lazy var labelStackView = createStackView(subviews: views)
    private let favouriteButton = UIBarButtonItem()
    private let segmentedUIView = UIView()
    private var segmentedController = UISegmentedControl()

    //MARK: Private Propeties
    private lazy var views: [UIView] = [ratingDishLabel, minutesLabel, difficultyLabel]
    private let networkManager = NetworkManager.shared
//    private var recipes: [Recipe] = []
    var recipe: Recipe? {
        didSet {
            guard let recipe = recipe else { return }
            dishImage.image = UIImage(named: recipe.image) ?? UIImage(systemName: "tray")
            ratingDishLabel.text = "\(recipe.rating) ★"
            minutesLabel.text = "\(recipe.cookTimeMinutes) Min"
            difficultyLabel.text = recipe.difficulty
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        updateUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentedUIView.layer.cornerRadius = segmentedUIView.bounds.height / 2
    }

}

private extension DetailReceiptViewController {

    func updateUI() {

        let imageURL = URL(string: recipe?.image ?? "")
        guard let imageURL else {
            print("Invalid image URL: \(recipe?.image ?? "")")
            return
        }

        networkManager.fetch(from: imageURL) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let imageData):
                        self.dishImage.image = UIImage(data: imageData)
                    case .failure(let error):
                        print(error)
                }

            }
        }

        ratingDishLabel.text = "\(recipe?.rating ?? 0)"
        minutesLabel.text = "\(recipe?.cookTimeMinutes ?? 0)"
        difficultyLabel.text = recipe?.difficulty
    }


    //MARK: Configure UI
    func setupUI() {
        addSubviews()

        constraintsDishImage()
        constraintsStackView()
        constraintsContainerSegmentoController()
        constraintsSegmentedCotroller()
    }

    func addSubviews() {
        view.addSubview(dishImage)
        view.addSubview(labelStackView)
        view.addSubview(segmentedUIView)
        configureContainerSegmentoController()
        configureSegmentoController()
        segmentedUIView.addSubview(segmentedController)
    }

    func configureContainerSegmentoController() {
        segmentedUIView.clipsToBounds = true
        segmentedUIView.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureSegmentoController() {
        segmentedController = UISegmentedControl(items: ["One", "Two"])

        segmentedController.selectedSegmentIndex = 0
        segmentedController.selectedSegmentTintColor = .black
        segmentedController.backgroundColor = .clear
        segmentedController.backgroundColor = .systemGray6
        segmentedController.clipsToBounds = true
        segmentedController.layer.masksToBounds = true
        segmentedController.layer.cornerRadius = 40

        segmentedController.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedController.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentedController.translatesAutoresizingMaskIntoConstraints = false

        segmentedController.addTarget(self, action: #selector(tapSegmentedController), for: .valueChanged)
    }

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
    func constraintsDishImage() {
        NSLayoutConstraint.activate([
            dishImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dishImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dishImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dishImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }

    func constraintsStackView() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: dishImage.bottomAnchor, constant: 10),
            labelStackView.leadingAnchor.constraint(equalTo: dishImage.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: dishImage.trailingAnchor)
        ])
    }

    func constraintsContainerSegmentoController() {
        NSLayoutConstraint.activate([
            segmentedUIView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 10),
            segmentedUIView.leadingAnchor.constraint(equalTo: dishImage.leadingAnchor),
            segmentedUIView.trailingAnchor.constraint(equalTo: dishImage.trailingAnchor),
            segmentedUIView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04)
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
}


private extension DetailReceiptViewController {

        //MARK: UI Helper
    func addLabel(
        font: UIFont = UIFont.systemFont(ofSize: 13, weight: .light),
        textColor: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        minimumScaleFactor: CGFloat = 0.9
    ) -> UILabel {
        {
        $0.font = font
        $0.text = " asdasdasdasd "
        $0.textColor = textColor
        $0.textAlignment = .left
        $0.minimumScaleFactor = 0.9
        $0.adjustsFontForContentSizeCategory = true
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
        }(UILabel())
    }

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

}

    // Add UIImage extension for creating solid color images
    extension UIImage {
        convenience init?(color: UIColor, size: CGSize) {
            let rect = CGRect(origin: .zero, size: size)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            color.setFill()
            UIRectFill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            guard let cgImage = image?.cgImage else { return nil }
            self.init(cgImage: cgImage)
        }
    }

//extension DetailReceiptViewController {
//    func fetchReceites() {
//        networkManager.fetch(Recipes.self, from: Links.receipt.url) { [weak self] result in
//            guard let self else { return }
//            switch result {
//                case .success(let dataReceipt):
//                    self.recipes = dataReceipt.recipes
//                case .failure(let error):
//                    print(error)
//                    showAlert(with: .failed)
//            }
//        }
//    }
//}

#Preview {
    let view = DetailReceiptViewController()
    view
}
