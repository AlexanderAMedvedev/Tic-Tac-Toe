//
//  ViewController.swift
//  Крестики-нолики
//
//  Created by Александр Медведев on 05.04.2024.
//

import UIKit

final class MainViewController: UIViewController {
    private var tableStateMatrix = [0,0,0,
                                    0,0,0,
                                    0,0,0]
    
    private var oneWins = 0
    private var twoWins = 0
    
    private var turn = 1   // 1-x, 2-o
    
    private var regime: Int //1-PvsP; 2-PvsC
    
    private var nameX: String
    private var nameO: String
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = nameX
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    private lazy var buttonsCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsVerticalScrollIndicator = false
        collection.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsCollectionViewCell.reuseIdentifier)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var chooseRegimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать игру", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 34, weight: .bold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTapChooseRegimeButton), for: .touchUpInside)
        return button
    }()
    
    init(regime: Int, nameX: String, nameO: String){
        self.regime = regime
        self.nameX = nameX
        if regime == 1 {
            self.nameO = nameO
        } else {
            self.nameO = "Компьютер"
        }
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
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        makeAndShowChooseRegimeAlert()
    }*/

    private func makeAndShowChooseRegimeAlert() {
        let alert = UIAlertController(title: "Выбор варианта игры", message: "", preferredStyle: .alert)
        
        let actionHuman = UIAlertAction(title: "Игрок против игрока", style: .default) { [weak self] _ in
            guard let self else { return }
            self.regime = 1
            self.oneWins = 0
            self.twoWins = 0
            self.startFromtheBeginning()
        }
        alert.addAction(actionHuman)
        
        let actionComputer = UIAlertAction(title: "Игрок против компьютера", style: .default) { [weak self] _ in
            guard let self else { return }
            self.regime = 2
            self.oneWins = 0
            self.twoWins = 0
            self.startFromtheBeginning()
        }
        alert.addAction(actionComputer)
        present(alert, animated: true)
    }
    
    private func setupUI() {
        [statusLabel,
         buttonsCollectionView,
         chooseRegimeButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupLayout() {
        let viewSafe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: viewSafe.topAnchor, constant: 16),
            statusLabel.centerXAnchor.constraint(equalTo: viewSafe.centerXAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            statusLabel.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            statusLabel.heightAnchor.constraint(equalToConstant: 64),
            
            buttonsCollectionView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 32),
            buttonsCollectionView.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            buttonsCollectionView.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            buttonsCollectionView.bottomAnchor.constraint(equalTo: viewSafe.bottomAnchor, constant: -32),
            
            chooseRegimeButton.bottomAnchor.constraint(equalTo: viewSafe.bottomAnchor, constant: -32),
            chooseRegimeButton.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor, constant: 32),
            chooseRegimeButton.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor, constant: -32),
            chooseRegimeButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    @objc private func didTapChooseRegimeButton() {
        makeAndShowChooseRegimeAlert()
    }
    
    private func scanTableStateMatrix() {
        
        var onesArray = [Int]()
        var twosArray = [Int]()
        
        for i in 0..<tableStateMatrix.count {
            if tableStateMatrix[i] == 1 {
                onesArray.append(i)
            } else if tableStateMatrix[i] == 2 {
                twosArray.append(i)
            }
        }
        if turn == 1 {
            checkArray(onesArray, twosArray )
        } else {
            checkArray(twosArray, onesArray)
        }
    }
    
    private func checkArray(_ array: [Int], _ arrayTwo: [Int]) {
        if array.count < 3 {
            changePlayer()
        } else {
            if array.contains(0) && array.contains(1) && array.contains(2) {
                win()
            } else if array.contains(3) && array.contains(4) && array.contains(5) {
                win()
            } else if array.contains(6) && array.contains(7) && array.contains(8) {
                win()
            } else if array.contains(0) && array.contains(3) && array.contains(6) {
                win()
            } else if array.contains(1) && array.contains(4) && array.contains(7) {
                win()
            } else if array.contains(2) && array.contains(5) && array.contains(8) {
                win()
            } else if array.contains(0) && array.contains(4) && array.contains(8) {
                win()
            } else if array.contains(2) && array.contains(4) && array.contains(6) {
                win()
            } else if (array.count + arrayTwo.count) == tableStateMatrix.count {
                end()
            } else {
                changePlayer()
            }
        }
    }
    
    private func changePlayer() {
        if turn == 1 {
            turn = 2
            statusLabel.text = nameO
            if regime == 2 {
                computerDidTapButton()
            }
        } else {
            turn = 1
            statusLabel.text = nameX
        }
    }
    
    private func win() {
        statusLabel.text = "Победа"
        if turn == 1 {
            oneWins += 1
        } else if turn == 2 {
            twoWins += 1
        }
        makeAndShowFinalAlert()
    }
     
    private func end() {
        statusLabel.text = "Ничья"
        oneWins += 1; twoWins += 1
        makeAndShowFinalAlert()
    }
    
    private func makeAndShowFinalAlert() {
        let message = """
        \(nameX) - \(nameO)
        \(oneWins) - \(twoWins)
        Будете ещё?
        """
        let alert = UIAlertController(title: "Конец игры", message: message, preferredStyle: .alert)
        
        let actionNo = UIAlertAction(title: "Нет", style: .default)
        alert.addAction(actionNo)
        
        let actionYes = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            guard let self else { return }
            self.startFromtheBeginning()
        }
        alert.addAction(actionYes)
        present(alert, animated: true)
    }
    
    private func startFromtheBeginning() {
        tableStateMatrix = [0,0,0,
                            0,0,0,
                            0,0,0]
        turn = 1
        statusLabel.text = nameX
        refreshButtons()
    }
    
    private func refreshButtons() {
        buttonsCollectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.reuseIdentifier, for: indexPath)
        guard let cell = (cell as? ButtonsCollectionViewCell) else {
            print("Cell of the needed type was not created")
            return UICollectionViewCell()
        }

        cell.delegate = self
        cell.configure(tableStateMatrix[indexPath.item])
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let parameter = (collectionView.bounds.width-18)/3
        return CGSize(width: parameter, height: parameter)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
}

extension MainViewController: ButtonsCollectionViewCellDelegate {
    
    func didTapXOButton(_ cell: ButtonsCollectionViewCell) {
        guard let indexPath = buttonsCollectionView.indexPath(for: cell) else {
            print("Can not get the indexPath of the tapped button")
            return
        }
        guard tableStateMatrix[indexPath.item] == 0 else { return }
        if turn == 1 {
            doAfterFirstTap(indexPath, state: 1)
        } else {
            doAfterFirstTap(indexPath, state: 2)
        }
    }
    
    private func doAfterFirstTap(_ indexPath: IndexPath, state: Int) {
        tableStateMatrix[indexPath.item] = state
        buttonsCollectionView.reloadItems(at: [indexPath])
        scanTableStateMatrix()
    }
}
extension MainViewController {
    
    private func computerDidTapButton() {
        doAfterFirstTap(prepareMove(), state: 2)
    }
    
    private func prepareMove() -> IndexPath {
        // Если два символа компьютера грозят победой, то занять третье место и выиграть
        var twosArray: [Int] = []
        for i in 0..<tableStateMatrix.count {
            if tableStateMatrix[i] == 2 {
                twosArray.append(i)
            }
        }
        
        if let item = findTheThirdPosition(array: twosArray) {
            return IndexPath(item: item, section: 0)
        }
        
        // Если два символа пользователя грозят победой, то занять третье место
        var onesArray: [Int] = []
        for i in 0..<tableStateMatrix.count {
            if tableStateMatrix[i] == 1 {
                onesArray.append(i)
            }
        }
        
        if let item = findTheThirdPosition(array: onesArray) {
            return IndexPath(item: item, section: 0)
        }
        
        // Если не грозит победа пользователя или компьютера, то поставить в случайное место
        var possibleMoves = [Int]()
        
        for i in 0..<tableStateMatrix.count {
            if tableStateMatrix[i] == 0 {
                possibleMoves.append(i)
            }
        }
        return IndexPath(item: possibleMoves.randomElement()!, section: 0)
    }
    private func findTheThirdPosition(array: [Int]) -> Int? {
      if      array.contains(0) && array.contains(1) && tableStateMatrix[2] == 0 {
        return 2
    } else if array.contains(1) && array.contains(2) && tableStateMatrix[0] == 0 {
        return 0
    } else if array.contains(0) && array.contains(2) && tableStateMatrix[1] == 0 {
        return 1
    } else if array.contains(3) && array.contains(4) && tableStateMatrix[5] == 0 {
        return 5
    } else if array.contains(3) && array.contains(5) && tableStateMatrix[4] == 0 {
        return 4
    } else if array.contains(4) && array.contains(5) && tableStateMatrix[3] == 0 {
        return 3
    } else if array.contains(6) && array.contains(7) && tableStateMatrix[8] == 0 {
        return 8
    } else if array.contains(6) && array.contains(8) && tableStateMatrix[7] == 0 {
        return 7
    } else if array.contains(7) && array.contains(8) && tableStateMatrix[6] == 0 {
        return 6
    } else if array.contains(0) && array.contains(3) && tableStateMatrix[6] == 0 {
        return 6
    } else if array.contains(0) && array.contains(6) && tableStateMatrix[3] == 0 {
        return 3
    } else if array.contains(3) && array.contains(6) && tableStateMatrix[0] == 0 {
        return 0
    } else if array.contains(1) && array.contains(4) && tableStateMatrix[7] == 0 {
        return 7
    } else if array.contains(1) && array.contains(7) && tableStateMatrix[4] == 0 {
        return 4
    } else if array.contains(4) && array.contains(7) && tableStateMatrix[1] == 0 {
        return 1
    } else if array.contains(2) && array.contains(5) && tableStateMatrix[8] == 0 {
        return 8
    } else if array.contains(2) && array.contains(8) && tableStateMatrix[5] == 0 {
        return 5
    } else if array.contains(5) && array.contains(8) && tableStateMatrix[2] == 0 {
        return 2
    } else if array.contains(0) && array.contains(4) && tableStateMatrix[8] == 0 {
        return 8
    } else if array.contains(0) && array.contains(8) && tableStateMatrix[4] == 0 {
        return 4
    } else if array.contains(4) && array.contains(8) && tableStateMatrix[0] == 0 {
        return 0
    } else if array.contains(2) && array.contains(4) && tableStateMatrix[6] == 0 {
        return 6
    } else if array.contains(2) && array.contains(6) && tableStateMatrix[4] == 0 {
        return 4
    } else if array.contains(4) && array.contains(6) && tableStateMatrix[2] == 0 {
        return 2
    } else {
        return nil
    }
    }
}

