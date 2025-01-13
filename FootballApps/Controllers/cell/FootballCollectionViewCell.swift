//
//  FootballCollectionViewCell.swift
//  FootballApps
//
//  Created by Putilov Nikita on 31.07.2024.
//

import UIKit

final class FootballCollectionViewCell: UICollectionViewCell {
    //MARK: - Labels
    // Изображение эмблемы
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // Название команды с интергированым шрифтом
    private let teamLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.init(name: "FIFA", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // Изображение рейтинга - звезды
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Подготовка к использованию
    static let collectionViewCellID = "collectionViewCellID"
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = nil
        teamLabel.text = nil
        starImageView.image = nil
    }
    //MARK: - override init
    // Этот метод отрабатывает, как viewDidLoad
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    // Отрисовка экрана
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Обрезаем углы сверху у teamLabel
        let teamLabelMaskPath = UIBezierPath(roundedRect: teamLabel.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        let teamLabelMaskLayer = CAShapeLayer()
        teamLabelMaskLayer.path = teamLabelMaskPath.cgPath
        teamLabel.layer.mask = teamLabelMaskLayer
        
        // Обрезаем углы снизу у starImageView
        let starImageViewMaskPath = UIBezierPath(roundedRect: starImageView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let starImageViewMaskLayer = CAShapeLayer()
        starImageViewMaskLayer.path = starImageViewMaskPath.cgPath
        starImageView.layer.mask = starImageViewMaskLayer
    }
    
    private func setupViews() {
        self.addSubview(cellImageView)
        self.addSubview(teamLabel)
        self.addSubview(starImageView)
        
    }
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -42),
            
            teamLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 3),
            teamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            teamLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            teamLabel.heightAnchor.constraint(equalToConstant: 16),
            
            starImageView.topAnchor.constraint(equalTo:  teamLabel.bottomAnchor, constant: 1),
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            starImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            starImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
        ])
    }
    
    public func setupCell(model: TeamModel) {
        cellImageView.image = UIImage(named: model.image)
        teamLabel.text = model.name
        starImageView.image = UIImage(named: "\(model.star)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
