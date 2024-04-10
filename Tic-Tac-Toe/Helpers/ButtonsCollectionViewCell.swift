//
//  ButtonsCollectionViewCell.swift
//  Крестики-нолики
//
//  Created by Александр Медведев on 05.04.2024.
//

import UIKit

final class ButtonsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ButtonsCollectionViewCell"
    weak var delegate: ButtonsCollectionViewCellDelegate?
    private lazy var XOButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(didTapXOButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [XOButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            XOButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            XOButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            XOButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            XOButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
            
    }
    
    @objc private func didTapXOButton() {
        delegate?.didTapXOButton(self)
    }
    
    func configure(_ state: Int) {
        if state == 0 {
            XOButton.setImage(UIImage(systemName: "swift"), for: .normal)
        } else if state == 1 {
            XOButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        } else if state == 2 {
            XOButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
}
