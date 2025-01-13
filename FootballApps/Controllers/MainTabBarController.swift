//
//  MainTabBarController.swift
//  FootballApps
//
//  Created by Putilov Nikita on 29.07.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        setupItems()
    }
    
    private func setupTabbar() {
        tabBar.backgroundColor = .black.withAlphaComponent(0.6)
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .white
        tabBar.layer.borderColor = UIColor.white.cgColor
        tabBar.layer.borderWidth = 0.2
    }
    
    private func setupItems() {
        let mainVC = MainViewController()
        let scoreVC = ScoreViewController()
        let tableVC = WebViewController()
        
        setViewControllers([mainVC,
                            scoreVC,
                            tableVC], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Рандомайзер"
        items[1].title = "Счет"
        items[2].title = "Таблица"
        
        items[0].image = UIImage(systemName: "cube")
        items[1].image = UIImage(systemName: "tablecells")
        items[2].image = UIImage(systemName: "calendar")
    }
}
