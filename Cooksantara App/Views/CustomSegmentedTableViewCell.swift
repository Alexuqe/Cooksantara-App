//
//  CustomSegmentedTableViewCell.swift
//  Cooksantara App
//
//  Created by Sasha on 19.01.25.
//

import UIKit

final class CustomSegmentedTableViewCell: UITableViewCell {

        //MARK: Private Outlets
    private let stepCircleButton: UIButton = {
        let circleButton = UIButton(type: .custom)
        var configure = UIButton.Configuration.bordered()
        configure.cornerStyle = .capsule
        configure.background.strokeColor = .systemGray5
        configure.baseForegroundColor = .gray
        configure.baseBackgroundColor = .clear
        configure.image = UIImage(systemName: "checkmark")
        configure.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(
            pointSize: 15,
            weight: .regular)

        configure.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)

        circleButton.configuration = configure
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        return circleButton
    }()

    private let stepLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Step 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

        //MARK: Properties
    static let identifer = "CustomSegmentedCell"

    private var isButtonSelected = false

    //MARK: Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()

        contentView.isUserInteractionEnabled = false
        stepCircleButton.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(ingredients: String) {
        stepLabel.text = ingredients
    }

}


private extension CustomSegmentedTableViewCell {
    func setupUI() {
        addSubview(stepCircleButton)
        addSubview(stepLabel)
        configureActionButton()
        constraintsCircleButton()
        constraintsStepLabel()
    }

    func configureActionButton() {
        stepCircleButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }

    @objc func tapButton(_ sender: UIButton) {
        isButtonSelected.toggle()
        var newConfig = stepCircleButton.configuration
        switch isButtonSelected {
            case true:
                newConfig?.baseBackgroundColor = .black
                newConfig?.baseForegroundColor = .white
                newConfig?.background.strokeColor = .clear
                stepCircleButton.layer.cornerRadius = stepCircleButton.frame.height / 2
            case false:
                newConfig?.baseBackgroundColor = .clear
                newConfig?.baseForegroundColor = .gray
                newConfig?.background.strokeColor = .systemGray5
                stepCircleButton.layer.cornerRadius = stepCircleButton.frame.height / 2
        }
        stepCircleButton.configuration = newConfig
    }

    func constraintsCircleButton() {
        NSLayoutConstraint.activate([
            stepCircleButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stepCircleButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stepCircleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stepCircleButton.heightAnchor.constraint(equalToConstant: 40),
            stepCircleButton.widthAnchor.constraint(equalTo: stepCircleButton.heightAnchor)
        ])
    }

    func constraintsStepLabel() {
        NSLayoutConstraint.activate([
            stepLabel.leadingAnchor.constraint(equalTo: stepCircleButton.trailingAnchor, constant: 20),
            stepLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stepLabel.centerYAnchor.constraint(equalTo: stepCircleButton.centerYAnchor),
            stepLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }



}

#Preview {
    let view = CustomSegmentedTableViewCell()
    view
}
