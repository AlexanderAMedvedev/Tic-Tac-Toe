//
//  ChooseRegimeViewController.swift
//  Tic-Tac-Toe
//
//  Created by Александр Медведев on 10.04.2024.
//

import UIKit

final class ChooseRegimeViewController: UIViewController {
    
    private lazy var sentenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите игру:"
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
    
    private lazy var PvsPregimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Игрок против игрока", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTapPvsPregimeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var PvsСregimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Игрок против компьютера", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTapPvsСregimeButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        [sentenceLabel,
         PvsPregimeButton,
         PvsСregimeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints=false
            view.addSubview($0)
        }
    }
    
    private func setupLayout() {
        let viewSafe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            sentenceLabel.topAnchor.constraint(equalTo: viewSafe.topAnchor, constant: 16),
            sentenceLabel.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            sentenceLabel.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            sentenceLabel.heightAnchor.constraint(equalToConstant: 64),
            
            PvsPregimeButton.topAnchor.constraint(equalTo: sentenceLabel.bottomAnchor, constant: 32),
            PvsPregimeButton.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            PvsPregimeButton.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            PvsPregimeButton.heightAnchor.constraint(equalToConstant: 64),
            
            PvsСregimeButton.topAnchor.constraint(equalTo: PvsPregimeButton.bottomAnchor, constant: 9),
            PvsСregimeButton.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            PvsСregimeButton.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            PvsСregimeButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    @objc private func didTapPvsPregimeButton() {
        let setNamesViewController = SetNamesViewController(regime: 1)
        present(setNamesViewController, animated: true)
    }
    
    @objc private func didTapPvsСregimeButton() {
        let setNamesViewController = SetNamesViewController(regime: 2)
        present(setNamesViewController, animated: true)
    }
}
