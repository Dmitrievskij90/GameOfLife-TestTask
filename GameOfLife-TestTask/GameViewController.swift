//
//  ViewController.swift
//  GameOfLife-TestTask
//
//  Created by Konstantin Dmitrievskiy on 07.07.2022.
//

import UIKit

class GameViewController: UIViewController {
    private var gameField = GameFieldView()
    
    private var gameLabel: UILabel = {
        let label = UILabel()
        label.text = "GAME OF LIFE"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private var startButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var randomButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Random", for: .normal)
        button.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
        return button
    }()

    private var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        self.view = view

        view.addSubview(gameLabel)
        view.addSubview(gameField)

        stackView = UIStackView(arrangedSubviews: [startButton, randomButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        view.addSubview(stackView)
    }
    
    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }

    private func setupLayout() {
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameField.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameLabel.widthAnchor.constraint(equalToConstant: 200),
            gameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            gameField.widthAnchor.constraint(equalTo: view.widthAnchor),
            gameField.heightAnchor.constraint(equalTo: view.widthAnchor),
            gameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    @objc private func startButtonPressed() {
        gameField.startButtonPressed()
        if gameField.isPlaying {
            startButton.setTitle("Stop", for: .normal)
        } else {
            startButton.setTitle("Start", for: .normal)
        }
    }
    
    @objc private func randomButtonPressed() {
        gameField.randomButtonPressed()
    }
}

