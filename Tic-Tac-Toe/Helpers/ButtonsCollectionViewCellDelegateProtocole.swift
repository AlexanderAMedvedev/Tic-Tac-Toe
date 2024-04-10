//
//  ButtonsCollectionViewCellDelegateProtocole.swift
//  Крестики-нолики
//
//  Created by Александр Медведев on 05.04.2024.
//

import Foundation

protocol ButtonsCollectionViewCellDelegate: AnyObject {
    func didTapXOButton(_ cell: ButtonsCollectionViewCell)
}
