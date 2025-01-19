//
//  PlaceholderUIView.swift
//  Cooksantara App
//
//  Created by Sasha on 13.01.25.
//

import UIKit

final class PlaceholderUIView: UIView {

    //MARK: Private Outlets
     let nameDishLabel = UILabel()
     let ratingDishLabel = UILabel()
     let favouriteButton = UIButton()


    //MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: Update UI
    private func updateUI() {
        configureUIView()
        configureFavouriteButton()
        configureNameDishLabel()
        configureRatingDishLabel()
    }


    //MARK: Configure UI
    private func configureUIView() {
        backgroundColor = .backgroundPlaceholderView
        translatesAutoresizingMaskIntoConstraints = false

        
    }

    private func configureFavouriteButton() {
        var configure = UIButton.Configuration.filled()
        configure.image = UIImage(systemName: "bookmark.fill")
        configure.baseForegroundColor = .startButton
        configure.baseBackgroundColor = .clear
        configure.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        favouriteButton.configuration = configure
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(favouriteButton)
        constraintsFavouriteButton()
    }

    private func configureNameDishLabel() {
        nameDishLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        nameDishLabel.textColor = .white
        nameDishLabel.textAlignment = .left
        nameDishLabel.minimumScaleFactor = 0.9
        nameDishLabel.numberOfLines = 2
        nameDishLabel.adjustsFontForContentSizeCategory = true
        nameDishLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(nameDishLabel)
        constraintsNameDishLabel()
    }

    private func configureRatingDishLabel() {
        ratingDishLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        ratingDishLabel.textColor = .white
        ratingDishLabel.textAlignment = .left
        ratingDishLabel.minimumScaleFactor = 0.9
        ratingDishLabel.adjustsFontForContentSizeCategory = true
        ratingDishLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(ratingDishLabel)
        constraintsRatingDishLabel()
    }

//MARK: Constraints UI
    private func constraintsFavouriteButton() {
        NSLayoutConstraint.activate([
            favouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favouriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            favouriteButton.widthAnchor.constraint(equalTo: favouriteButton.heightAnchor)
        ])
    }

    private func constraintsNameDishLabel() {
        NSLayoutConstraint.activate([
            nameDishLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameDishLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameDishLabel.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -30)
        ])
    }

    private func constraintsRatingDishLabel() {
        NSLayoutConstraint.activate([
            ratingDishLabel.topAnchor.constraint(equalTo: nameDishLabel.bottomAnchor, constant: 15),
            ratingDishLabel.leadingAnchor.constraint(equalTo: nameDishLabel.leadingAnchor),
            ratingDishLabel.trailingAnchor.constraint(equalTo: nameDishLabel.trailingAnchor),
            ratingDishLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }


}

#Preview {
    let view = HomeViewController()
    view
}
