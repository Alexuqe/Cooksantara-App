//
//  DetailReceiptViewController.swift
//  Cooksantara App
//
//  Created by Sasha on 16.01.25.
//

import UIKit

enum ShowSegmented {
    case firstScreen
    case secondScreen
}

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
    private lazy var segmentedController: UISegmentedControl = {
        var segmented = UISegmentedControl()
        segmented = UISegmentedControl(items: ["Ingredients", "Instructions"])
        segmented.selectedSegmentIndex = 0
        segmented.selectedSegmentTintColor = .black
        segmented.backgroundColor = .clear
        segmented.clipsToBounds = true
        segmented.layer.masksToBounds = true
        segmented.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 17)], for: .selected)
        segmented.setTitleTextAttributes([.foregroundColor: UIColor.systemGray, .font: UIFont.systemFont(ofSize: 17)], for: .normal)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()

    private lazy var customSegmentedController = CustomSegmentedCotroll("Ingredients", "Directions")

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

    private lazy var instructionsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

//MARK: Properties
    var recipes: Recipe?
    var instructionOnTable: [String] = []

    //MARK: Private Propeties
    private lazy var views: [UIView] = [ratingDishLabel, minutesLabel, difficultyLabel]
    private let networkManager = NetworkManager.shared

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        scrollView.delegate = self
        instructionsTableView.delegate = self
        instructionsTableView.dataSource = self

        setupUI()
        registerTableViewCell()
//        fetchReceites()
        print(instructionOnTable)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI()
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
        constraintsIngredientsLabel()
        constraintsInstructionTableView()
        activituIndicator.startAnimating()
    }

    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        configureSegmentoController()
        viewsInContentView()
    }

    func viewsInContentView() {
        let viewArray = [dishImage, activituIndicator, labelStackView, segmentedController, ingredientsLabel, instructionsTableView]
        viewArray.forEach {contentView.addSubview($0)}
    }

    func configureSegmentoController() {
        segmentedController.addTarget(self, action: #selector(tapSegmentedController), for: .valueChanged)
    }

    func registerTableViewCell() {
        instructionsTableView.register(CustomSegmentedTableViewCell.self, forCellReuseIdentifier: CustomSegmentedTableViewCell.identifer)
    }

    //MARK: Action
    @objc func tapSegmentedController(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                instructionsTableView.isHidden = true
                ingredientsLabel.isHidden = false
            default:
                instructionsTableView.isHidden = false
                ingredientsLabel.isHidden = true
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
            segmentedController.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 10),
            segmentedController.leadingAnchor.constraint(equalTo: dishImage.leadingAnchor),
            segmentedController.trailingAnchor.constraint(equalTo: dishImage.trailingAnchor),
            segmentedController.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    func costraintsCustomSegmentedView() {
        NSLayoutConstraint.activate([
            customSegmentedController.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 20),
            customSegmentedController.leadingAnchor.constraint(equalTo: dishImage.leadingAnchor),
            customSegmentedController.trailingAnchor.constraint(equalTo: dishImage.trailingAnchor),
            customSegmentedController.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.115)

        ])
    }

    func constraintsIngredientsLabel() {
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 20),
            ingredientsLabel.leadingAnchor.constraint(equalTo: segmentedController.leadingAnchor, constant: 5),
            ingredientsLabel.trailingAnchor.constraint(equalTo: segmentedController.trailingAnchor, constant: -5),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -90)
        ])
    }

    func constraintsInstructionTableView() {
        NSLayoutConstraint.activate([
            instructionsTableView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 5),
            instructionsTableView.leadingAnchor.constraint(equalTo: segmentedController.leadingAnchor, constant: 5),
            instructionsTableView.trailingAnchor.constraint(equalTo: segmentedController.trailingAnchor, constant: -5),
            instructionsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
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

//MARK: ScrollDelagate
extension DetailReceiptViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let dishImageHeight = dishImage.frame.height

        if offsetY > 0 {
            let scale = max(1 - offsetY / dishImageHeight, 0.8)
            dishImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        } else {
            dishImage.transform = .identity
        }
    }
}


#Preview {
    let view = DetailReceiptViewController()
    view
}
