//
//  CustomSegmentedCotroll.swift
//  Cooksantara App
//
//  Created by Sasha on 20.01.25.
//

import UIKit

final class CustomSegmentedCotroll: UIView {

    private let stackView = UIStackView()
    private let selectedView = UIView()

    private var widthConstraint = NSLayoutConstraint()
    private var leadinConstraint = NSLayoutConstraint()

    private var buttons: [UIButton] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureStackView()
        configureSelectedView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(_ buttonText: String...) {
        self.init()
        buttonText.enumerated().forEach {
            let button: UIButton = .createdSegmentedButton(title: $0.element)
            button.tag = $0.offset
            button.addTarget(self, action: #selector(segmentedButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.widthConstraint.constant = self.stackView.arrangedSubviews[0].frame.width
            self.buttons[1].setTitleColor(.black, for: .normal)
        }
    }

    @objc private func segmentedButtonTapped(sender: UIButton) {
        widthConstraint.constant = stackView.arrangedSubviews[sender.tag].frame.width
        leadinConstraint.constant = stackView.arrangedSubviews[sender.tag].frame.origin.x
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            stateButtons(sender)
            self.stackView.layoutIfNeeded()
        }
    }

    func stateButtons(_ sender: UIButton) {
        buttons.forEach { button in
            button == sender
            ? button.setTitleColor(.white, for: .normal)
            : button.setTitleColor(.black, for: .normal)
        }
    }



}

private extension CustomSegmentedCotroll {

    func configure() {
        layer.cornerRadius = 20
        backgroundColor = .systemGray5
        translatesAutoresizingMaskIntoConstraints = false
    }

    func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
    }

    func configureSelectedView() {
        selectedView.backgroundColor = .black
        selectedView.layer.cornerRadius = 16
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(selectedView)
    }

    func setConstraints() {
        widthConstraint = selectedView.widthAnchor.constraint(equalToConstant: 0)
        leadinConstraint = selectedView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
        widthConstraint.isActive = true
        leadinConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),

            selectedView.topAnchor.constraint(equalTo: stackView.topAnchor),
            selectedView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }

}
