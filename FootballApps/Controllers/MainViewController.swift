//
//  MainViewControllers.swift
//  FootballApps
//
//  Created by Putilov Nikita on 24.07.2024.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    var player: AVAudioPlayer!
    
    private let topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black.withAlphaComponent(0.2)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black.withAlphaComponent(0.2)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    //MARK: - Images
    private let lawnImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.image.lawn
        return imageView
    }()
    
    private let versusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.image.versus
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    //MARK: - Buttons
    private let randomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rollCollectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Рандомайзер", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "FIFA", size: 18)
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.backgroundColor = .yellow
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var teamModel = TeamViewModel.teamModel
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupCollectionView()
        setConstraints()
        setTargets()
    }
    
    @objc private func randomButtonTapped() {
        UIView.animate(withDuration: 1.2, animations: {
            self.topCollectionView.alpha = 0.1
            self.bottomCollectionView.alpha = 0.1
        }) { (finished) in
            self.generateRandomArray(teamModel: &self.teamModel)
            self.bottomCollectionView.reloadData()
            self.topCollectionView.reloadData()
            
            UIView.animate(withDuration: 1.2, animations: {
                self.topCollectionView.alpha = 1.0
                self.bottomCollectionView.alpha = 1.0
            })
        }
        topCollectionView.isUserInteractionEnabled = true
        bottomCollectionView.isUserInteractionEnabled = true
        playSoundWhistle()
    }
    
    @objc private func scrollButtonTapped() {
        let randomIndexTop = Int.random(in: 0..<teamModel.count)
        let randomIndexBottom = Int.random(in: 0..<teamModel.count)
        
        UIView.animate(withDuration: 6.2, delay: 0, options: .curveEaseInOut, animations: {
            self.topCollectionView.scrollToItem(at: IndexPath(item: randomIndexTop, section: 0), at: .centeredHorizontally, animated: true)
            
            self.bottomCollectionView.scrollToItem(at: IndexPath(item: randomIndexBottom, section: 0), at: .centeredHorizontally, animated: true)
            self.bottomCollectionView.reloadData()
            self.topCollectionView.reloadData()
        })
        
        topCollectionView.isUserInteractionEnabled = false
        bottomCollectionView.isUserInteractionEnabled = false
        playSoundKick()
    }
    
    func setupCollectionView() {
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        topCollectionView.register(FootballCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        bottomCollectionView.register(FootballCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(lawnImageView)
        view.addSubview(topCollectionView)
        view.addSubview(bottomCollectionView)
        view.addSubview(versusImageView)
        view.addSubview(rollCollectionButton)
        view.addSubview(randomButton)
        lawnImageView.frame = view.bounds
        generateRandomArray(teamModel: &teamModel)
    }
    
    private func generateRandomArray(teamModel: inout [TeamModel]) {
        teamModel.shuffle()
    }
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            versusImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            versusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versusImageView.heightAnchor.constraint(equalToConstant: 220),
            versusImageView.widthAnchor.constraint(equalToConstant: 280),
            
            topCollectionView.bottomAnchor.constraint(equalTo: versusImageView.topAnchor, constant: 20),
            topCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topCollectionView.heightAnchor.constraint(equalToConstant: 216),
            topCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomCollectionView.topAnchor.constraint(equalTo: versusImageView.bottomAnchor, constant: -20),
            bottomCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomCollectionView.heightAnchor.constraint(equalToConstant: 216),
            bottomCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            rollCollectionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            rollCollectionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            rollCollectionButton.widthAnchor.constraint(equalToConstant: view.frame.width - 70),
            rollCollectionButton.heightAnchor.constraint(equalToConstant: 40),
            
            randomButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            randomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            randomButton.trailingAnchor.constraint(equalTo: rollCollectionButton.leadingAnchor, constant: -5),
            randomButton.heightAnchor.constraint(equalToConstant: 40),
            randomButton.widthAnchor.constraint(equalToConstant: 65),
        ])
    }
}
//MARK: - Targets
extension MainViewController{
    private func setTargets(){
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        rollCollectionButton.addTarget(self, action: #selector(scrollButtonTapped), for: .touchUpInside)
    }
}
//MARK: - Extension
// Отображение кол-ва элементов в массиве
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FootballCollectionViewCell
        let model = teamModel[indexPath.row]
        cell.setupCell(model: model)
        return cell
    }
    
    // Остановка в центре массива
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2
        let centerXCell = cell.frame.midX
        let offset = abs(centerX - centerXCell)
        
        let scale: CGFloat
        if offset < 100 {
            scale = 1.0
        } else {
            scale = 0.6
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    
    // Возвращение  в исходное состояние
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1, animations: {
            cell.transform = CGAffineTransform.identity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 160, height: 213)
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == topCollectionView {
            
            let centerX = scrollView.contentOffset.x + scrollView.bounds.width / 2
            let indexPaths = topCollectionView.indexPathsForVisibleItems
            
            for indexPath in indexPaths {
                if let cell = topCollectionView.cellForItem(at: indexPath) {
                    let centerXCell = cell.frame.midX
                    let offset = abs(centerX - centerXCell)
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                        let scale: CGFloat
                        if offset < 100 {
                            scale = 1.0
                        } else {
                            scale = 0.6
                        }
                        
                        UIView.animate(withDuration: 0.1, animations: {
                            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
                        })
                    })
                }
            }
        } else if scrollView == bottomCollectionView {
            let centerX = scrollView.contentOffset.x + scrollView.bounds.width / 2
            let indexPaths = bottomCollectionView.indexPathsForVisibleItems
            
            for indexPath in indexPaths {
                if let cell = bottomCollectionView.cellForItem(at: indexPath) {
                    let centerXCell = cell.frame.midX
                    let offset = abs(centerX - centerXCell)
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                        let scale: CGFloat
                        if offset < 100 {
                            scale = 1.0
                        } else {
                            scale = 0.6
                        }
                        
                        UIView.animate(withDuration: 0.1, animations: {
                            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
                        })
                    })
                }
            }
        }
    }
    
    func playSoundWhistle() {
        let url = Bundle.main.url(forResource: "whistle", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func playSoundKick() {
        let url = Bundle.main.url(forResource: "kick", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
