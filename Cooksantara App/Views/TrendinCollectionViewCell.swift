    //
    //  TrendinCollectionViewCell.swift
    //  Cooksantara App
    //
    //  Created by Sasha on 14.01.25.
    //

import UIKit

final class TrendinCollectionViewCell: UICollectionViewCell {

        //MARK: Properties
    static let identifer = "TrendinCollectionViewCell"

        //MARK: Private Properties
    private let networkManager = NetworkManager.shared
    private var expectedImageURL: String = ""
    private let dishImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let activituIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.contentMode = .scaleAspectFill
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let viewWithDetail = PlaceholderUIView()

        //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
        viewWithDetail.layer.cornerRadius = 20
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dishImage.image = nil
        activituIndicator.startAnimating()
        expectedImageURL = ""
    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        //MARK: Methods
    func set(with receipts: Recipe) {
        viewWithDetail.nameDishLabel.text = receipts.name
        viewWithDetail.ratingDishLabel.text = "\(receipts.rating) ★ | \(receipts.cookTimeMinutes) Min"

        let imageURL = URL(string: receipts.image)
        guard let imageURL else {
            print("Invalid image URL: \(receipts.image)")
            return
        }

        expectedImageURL = receipts.image
        activituIndicator.startAnimating()

        networkManager.fetch(from: imageURL) { [weak self] result in
            guard let self else { return }
            guard self.expectedImageURL == receipts.image else { return }
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
}

    //MARK: Private Methods
private extension TrendinCollectionViewCell {
    func updateUI() {
        dishImage.translatesAutoresizingMaskIntoConstraints = false
        viewWithDetail.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dishImage)
        addSubview(activituIndicator)
        addSubview(viewWithDetail)

        constraintsDishImage()
        constraintsActivityIndicator()
        constraintsViewWithDetail()
    }

    func constraintsDishImage() {
        NSLayoutConstraint.activate([
            dishImage.topAnchor.constraint(equalTo: topAnchor),
            dishImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dishImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            dishImage.trailingAnchor.constraint(equalTo: trailingAnchor)

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

    func constraintsViewWithDetail() {
        NSLayoutConstraint.activate([
            viewWithDetail.bottomAnchor.constraint(equalTo: dishImage.bottomAnchor, constant: -10),
            viewWithDetail.leadingAnchor.constraint(equalTo: dishImage.leadingAnchor, constant: 10),
            viewWithDetail.trailingAnchor.constraint(equalTo: dishImage.trailingAnchor, constant: -10),
            viewWithDetail.heightAnchor.constraint(equalTo: dishImage.heightAnchor, multiplier: 0.25)

        ])
    }



}


#Preview {
    let view = HomeViewController()
    view
}
