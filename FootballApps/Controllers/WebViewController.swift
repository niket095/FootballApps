//
//  TableViewController.swift
//  FootballApps
//
//  Created by Putilov Nikita on 29.07.2024.
//

import UIKit
import WebKit

//MARK: - WebViewController
class WebViewController: UIViewController {
    
    private let lawnImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.image.lawn
        return imageView
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = .clear
        webView.clipsToBounds = true
        webView.layer.cornerRadius = 10
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupUrl()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        lawnImageView.frame = view.bounds
        view.addSubview(lawnImageView)
        view.addSubview(webView)
    }
    
    private func setupUrl() {
        webView.navigationDelegate = self
        //ссылка для навигации
        guard let url = URL(string: "https://www.sports.ru/football/tournament/premier-league/table/") else { return }
        webView.load(URLRequest(url: url))
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
    }
}
//MARK: - Extension
extension WebViewController: WKNavigationDelegate {
    // Метод для запрета переходя на другие страницы кроме стартовой
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

