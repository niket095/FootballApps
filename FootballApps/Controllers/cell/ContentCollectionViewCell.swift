//
//  ContentCollectionViewCell.swift
//  FootballApps
//
//  Created by Putilov Nikita on 15.08.2024.
//


import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Labels
    let someLabel: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.font = UIFont.init(name: "FIFA", size: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreOneLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.init(name: "FIFA", size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.init(name: "FIFA", size: 15)
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Отрабатывает как viewDidLoad
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(someLabel)
        addSubview(scoreOneLabel)
        addSubview(scoreTwoLabel)
    }
    //MARK: - Constraitns
    private func setConstraints() {
        NSLayoutConstraint.activate([
            someLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            someLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            someLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            someLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            
            scoreOneLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreOneLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreOneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            scoreOneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            
            scoreTwoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreTwoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreTwoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            scoreTwoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    //MARK: - Настройка ячеек
    public func cellSetup() {
        someLabel.isHidden = false
        scoreOneLabel.isHidden = true
        scoreTwoLabel.isHidden = true
        someLabel.text = "0"
        someLabel.font = UIFont.init(name: "FIFA", size: 22)
        self.backgroundColor = .green
        self.isUserInteractionEnabled = true
    }
    
    public func cellSetup(isHidden: Bool) {
        someLabel.isHidden = isHidden ? true : false
        scoreOneLabel.isHidden = isHidden ? true : false
        scoreTwoLabel.isHidden = isHidden ? true : false
        self.backgroundColor = isHidden ? .red : .white
        self.isUserInteractionEnabled = isHidden ? false : true
    }
    
    public func cellTextSetup(isHidden: Bool) {
        self.isUserInteractionEnabled = isHidden ? false : true
        self.backgroundColor = .gray
        scoreOneLabel.isHidden = isHidden ? true : false
        scoreTwoLabel.isHidden = isHidden ? true : false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
