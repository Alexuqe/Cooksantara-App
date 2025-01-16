    //
    //  HeaderCollectionReusableView.swift
    //  Cooksantara App
    //
    //  Created by Sasha on 16.01.25.
    //

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    static let identifer = "HeaderCell"

        //MARK: Private Outlets
    lazy var headerImage: UIImageView = {
        let headerImage = UIImageView()
        headerImage.contentMode = .scaleAspectFit
//        headerImage.backgroundColor = .green
        headerImage.clipsToBounds = true

        headerImage.translatesAutoresizingMaskIntoConstraints = false
        return headerImage
    }()

    lazy var headerText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


        //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.directionalLayoutMargins = .zero
        self.layoutMargins = .zero
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        //MARK: Private Methods


}


private extension HeaderCollectionReusableView {
    private func setupUI() {
        addSubview(headerImage)
        addSubview(headerText)

        constraintsHeaderImage()
        constraintsHeaderText()
    }


        //MARK: Constraints
    func constraintsHeaderImage() {
        NSLayoutConstraint.activate([
            headerImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImage.topAnchor.constraint(equalTo: topAnchor),
            headerImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            headerImage.widthAnchor.constraint(equalTo: headerImage.heightAnchor)
        ])
    }

    func constraintsHeaderText() {
        NSLayoutConstraint.activate([
            headerText.leadingAnchor.constraint(equalTo: headerImage.trailingAnchor, constant: 15),
            headerText.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerText.centerYAnchor.constraint(equalTo: headerImage.centerYAnchor)
        ])
    }

}


#Preview {
    let view = HeaderCollectionReusableView()
    view
}


