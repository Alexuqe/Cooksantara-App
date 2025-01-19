//
//  ViewController.swift
//  Cooksantara App
//
//  Created by Sasha on 12.01.25.
//

import UIKit

final class LaunchViewController: UIViewController {

    //MARK: Private Outlets
    private let lauchImage = UIImageView()
    private let darkBlurView = UIView()
    private let logoView = UIImageView()
    private let lauchDescriptionLabel = UILabel()
    private let startButton = UIButton()

    //MARK: Private Properties
    let colorButton = UIColor.startButton

    deinit {
        print("screen is deinit")
    }


    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureGradientDarkBlurView()
    }

    //MARK: Action Button
    @objc private func startButtonAction() {
        navigateToTabBar()
    }

}

private extension LaunchViewController {
    //MARK: Navigate
    func navigateToTabBar() {
        let tabBarController = TabBarViewController()
        tabBarController.modalPresentationStyle = .fullScreen

        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
    }

    
    //MARK: Update UI
    func updateUI() {
        configureLaunchImageView()
        configureDarkBlurView()
        configureStartButton()
        configureLauchDescriptionLabel()
        configureLogoImageView()
    }


    //MARK: Configure UI
    func configureLaunchImageView() {
        lauchImage.image = .launch
        lauchImage.contentMode = .scaleAspectFill
        lauchImage.clipsToBounds = true
        lauchImage.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(lauchImage)
        configureConstraintsLaunchImage()
    }

    func configureDarkBlurView() {
        darkBlurView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(darkBlurView)
        configureConstraintsDarkBlurView()
    }

    func configureGradientDarkBlurView() {
        let primaryColor = UIColor.black.withAlphaComponent(0)
        let secondaryColor = UIColor.black

        darkBlurView.addVerticalGradient(
            primaryColor: primaryColor,
            secondaryColor: secondaryColor
        )
    }

    func configureStartButton() {
        let font = UIFont.systemFont(ofSize: 20, weight: .medium)
        let sizeImage = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)

        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .large
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 15,
            leading: 30,
            bottom: 15,
            trailing: 30)

        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.image = UIImage(
            systemName: "arrow.forward",
            withConfiguration: sizeImage)

        configuration.title = "Let's Start"
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = font
            return outgoing
        }

        configuration.baseBackgroundColor = colorButton
        configuration.baseForegroundColor = .white

        startButton.configuration = configuration
        startButton.clipsToBounds = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addDropShadow(color: .startButton, opacity: 0.4, radius: 20)

        view.addSubview(startButton)
        configureConstraintsStartButton()

        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
    }

    func configureLauchDescriptionLabel() {
        let text = "Cook indonesian food at home like \n A professional chef"
        let font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        let colorText = UIColor.white

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center

        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: font,
                .foregroundColor: colorText
            ])

        lauchDescriptionLabel.attributedText = attributedString
        lauchDescriptionLabel.numberOfLines = 2
        lauchDescriptionLabel.minimumScaleFactor = 0.8
        lauchDescriptionLabel.adjustsFontSizeToFitWidth = true
        lauchDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(lauchDescriptionLabel)
        configureConstraintsLauchDescriptionLabel()
    }

    func configureLogoImageView() {
        logoView.image = .logo
        logoView.contentMode = .scaleAspectFit
        lauchImage.clipsToBounds = true
        logoView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(logoView)
        configureConstraintsLogoImage()
    }


    //MARK: Configure Constraints
    func configureConstraintsLaunchImage() {
        NSLayoutConstraint.activate([
            lauchImage.topAnchor.constraint(equalTo: view.topAnchor),
            lauchImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lauchImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lauchImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func configureConstraintsDarkBlurView() {
        NSLayoutConstraint.activate([
            darkBlurView.topAnchor.constraint(equalTo: lauchImage.topAnchor),
            darkBlurView.leadingAnchor.constraint(equalTo: lauchImage.leadingAnchor),
            darkBlurView.trailingAnchor.constraint(equalTo: lauchImage.trailingAnchor),
            darkBlurView.bottomAnchor.constraint(equalTo: lauchImage.bottomAnchor)
        ])
    }

    func configureConstraintsStartButton() {
        let viewHeight = view.frame.height
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -viewHeight / 15),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06)

        ])
    }

    func configureConstraintsLauchDescriptionLabel() {
        NSLayoutConstraint.activate([
            lauchDescriptionLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -55),
            lauchDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lauchDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureConstraintsLogoImage() {
        NSLayoutConstraint.activate([
            logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            logoView.bottomAnchor.constraint(equalTo: lauchDescriptionLabel.topAnchor, constant: -35)
        ])
    }

}





#Preview {
    let view = LaunchViewController()
    view
}

