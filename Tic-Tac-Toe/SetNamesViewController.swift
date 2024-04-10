//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Александр Медведев on 09.04.2024.
//

import UIKit

class SetNamesViewController: UIViewController {
    
    private let regime: Int
    
    private lazy var sentenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите имена игроков"
        //label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textAlignment = .center
        //label.layer.borderColor = UIColor.black.cgColor
        //label.layer.borderWidth = 1
        return label
    }()
    
    private lazy var nameOneField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Игрок 1 (X)"
        textField.font = .systemFont(ofSize: 17)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private lazy var nameTwoField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Игрок 2 (O)"
        textField.font = .systemFont(ofSize: 17)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private lazy var startGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать игру", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 34, weight: .bold)
        //button.titleLabel?.adjustsFontSizeToFitWidth = true
        //button.titleLabel?.minimumScaleFactor = 0.5
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTapStartGameButton), for: .touchUpInside)
        return button
    }()
    
    init(regime: Int){
        self.regime = regime
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func setupUI() {
        [sentenceLabel,
         nameOneField,
         nameTwoField,
         startGameButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        if regime == 2 {
            nameTwoField.text = "Компьютер"
        }
    }

    private func setupLayout() {
        let viewSafe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            sentenceLabel.topAnchor.constraint(equalTo: viewSafe.topAnchor, constant: 16),
            sentenceLabel.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            sentenceLabel.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            sentenceLabel.heightAnchor.constraint(equalToConstant: 64),
            
            nameOneField.topAnchor.constraint(equalTo: sentenceLabel.bottomAnchor, constant: 32),
            nameOneField.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            nameOneField.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            nameOneField.heightAnchor.constraint(equalToConstant: 64),
            
            nameTwoField.topAnchor.constraint(equalTo: nameOneField.bottomAnchor, constant: 9),
            nameTwoField.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            nameTwoField.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            nameTwoField.heightAnchor.constraint(equalToConstant: 64),
                
            startGameButton.topAnchor.constraint(equalTo: nameTwoField.bottomAnchor, constant: 18),
            startGameButton.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            startGameButton.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            startGameButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    @objc private func didTapStartGameButton() {
        if regime == 2 {
            if nameOneField.text == "" {
                initAndPresentVC(nameX: "Игрок 1", nameO: "")
            } else {
                if let nameOne = nameOneField.text {
                    initAndPresentVC(nameX: nameOne, nameO: "")
                }
            }
        } else {
            if nameOneField.text == "" && nameTwoField.text == "" {
                initAndPresentVC(nameX: "Игрок 1", nameO: "Игрок 2")
            } else if nameOneField.text == "" && nameTwoField.text != "" {
                if let nameTwo = nameTwoField.text {
                    initAndPresentVC(nameX: "Игрок 1", nameO: nameTwo)
                }
            } else if nameOneField.text != "" && nameTwoField.text == "" {
                if let nameOne = nameOneField.text {
                    initAndPresentVC(nameX: nameOne, nameO: "Игрок 2")
                }
            } else {
                if let nameOne = nameOneField.text,
                   let nameTwo = nameTwoField.text {
                    initAndPresentVC(nameX: nameOne, nameO: nameTwo)
                }
            }
        }
    }
    
    private func initAndPresentVC(nameX: String, nameO: String) {
        let mainViewController = MainViewController(regime: regime, nameX: nameX, nameO: nameO)
        present(mainViewController, animated: true)
    }
}

extension SetNamesViewController: UITextFieldDelegate {
}
