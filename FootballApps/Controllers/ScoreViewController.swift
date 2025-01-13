//
//  ScoreViewController.swift
//  FootballApps
//
//  Created by Putilov Nikita on 29.07.2024.
//


import UIKit

class ScoreViewController:  UIViewController, UICollectionViewDelegate {
    
    private let lawnImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.image.lawn
        return imageView
    }()
    
    private let custCollectionViewLayout = CustomCollectionViewLayout()
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: CustomCollectionViewLayout())
    private let typeOfLesson = [" ","P1", "P2", "P3", "Total"]
    private let disciplins = [" ","P1", "P2", "P3"]
    private let contentCellID = "ContentCellID"
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(lawnImageView)
        view.addSubview(collectionView)
        lawnImageView.frame = view.bounds
        
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height),
        ])
    }
}
//MARK: - Extension
extension ScoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath) as! ContentCollectionViewCell
        
        if (indexPath.section == 1 && indexPath.row == 1) ||
            (indexPath.section == 2 && indexPath.row == 2) ||
            (indexPath.section == 3 && indexPath.row == 3) {
            cell.cellSetup(isHidden: true)
        } else if (indexPath.section == 1 && indexPath.row == 4) ||
                    (indexPath.section == 2 && indexPath.row == 4) ||
                    (indexPath.section == 3 && indexPath.row == 4) {
            cell.cellSetup()
            cell.backgroundColor = .green
        } else {
            cell.cellSetup(isHidden: false)
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.someLabel.text = "Таблица"
                    cell.someLabel.font = UIFont.boldSystemFont(ofSize: 14)
                    cell.cellTextSetup(isHidden: true)
                    cell.backgroundColor = .red
                } else {
                    cell.someLabel.text = typeOfLesson[indexPath.row]
                    cell.someLabel.font = UIFont.init(name: "FIFA", size: 20)
                    cell.cellTextSetup(isHidden: true)
                }
            } else {
                if indexPath.row == 0 {
                    cell.someLabel.text = disciplins[indexPath.section]
                    cell.someLabel.font = UIFont.init(name: "FIFA", size: 20)
                    cell.cellTextSetup(isHidden: true)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeOfLesson.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return disciplins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("INDEX:", indexPath)
        if (indexPath.section == 1 && indexPath.row == 4) ||
            (indexPath.section == 2 && indexPath.row == 4) ||
            (indexPath.section == 3 && indexPath.row == 4) {
            let alertController = UIAlertController(title: "Введите количество очков",
                                                    message: nil,
                                                    preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "0"
                textField.keyboardType = .numberPad
            }
            
            let saveAction = UIAlertAction(title: "Cохранить", style: .default) { _ in
                if let textFieldOne = alertController.textFields?.first {
                    if let scoreOne = textFieldOne.text {
                        //получаем ячейку по indexPath
                        if let cell = collectionView.cellForItem(at: indexPath) as? ContentCollectionViewCell {
                            cell.someLabel.text = scoreOne
                        }
                    }
                }
            }
            
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            alertController.addAction(saveAction)
            alertController.addAction(cancel)
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Введите счет",
                                                    message: nil,
                                                    preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "Счет 1"
                textField.keyboardType = .numberPad
            }
            
            alertController.addTextField { textField in
                textField.placeholder = "Счет 2"
                textField.keyboardType = .numberPad
            }
            
            let saveAction = UIAlertAction(title: "Cохранить", style: .default) { _ in
                if let textFieldOne = alertController.textFields?.first, let textFieldTwo = alertController.textFields?.last {
                    if let scoreOne = textFieldOne.text, let scoreTwo = textFieldTwo.text {
                        //получаем ячейку по indexPath
                        if let cell = collectionView.cellForItem(at: indexPath) as? ContentCollectionViewCell {
                            cell.scoreOneLabel.text = scoreOne
                            cell.scoreTwoLabel.text = scoreTwo
                        }
                    }
                }
            }
            
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            alertController.addAction(saveAction)
            alertController.addAction(cancel)
            present(alertController, animated: true)
        }
    }
}
