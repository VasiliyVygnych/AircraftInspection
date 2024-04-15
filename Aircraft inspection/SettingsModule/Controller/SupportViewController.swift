//
//  SupportViewController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 15.04.2024.
//

import UIKit
import SnapKit
import WebKit

class SupportViewController: UIViewController {
    
    var viewModel: SettingsViewModelProtocol?
    private var webView = WKWebView()
    
//MARK: UIButton
    private var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "arrow-left"),
                                  for: .normal)
        return button
    }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.view = self
        viewModel?.requestSupport()
        setupeWebView()
        addSubview()
        setupeConstraint()
        setupeButton()
        view.backgroundColor = UIColor(named: "background")
    }
//MARK: setupeWebView
    private func setupeWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .white
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(backButton)
        
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.width.height.equalTo(32)
            make.left.equalTo(20)
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(120)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(70)
        }
    }
//MARK: makeButton
    private func setupeButton() {
        backButton.addTarget(self,
                             action: #selector(popView),
                             for: .touchUpInside)
    }
    @objc func popView() {
        dismiss(animated: true)
    }
}
extension SupportViewController: SettingsControllerDelegate {
    func setRequest(request: URLRequest) {
        webView.load(request)
    }
}
