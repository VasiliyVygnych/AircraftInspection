//
//  UsagePolicyController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 15.04.2024.
//

import UIKit
import SnapKit
import WebKit

class UsagePolicyController: UIViewController,
                                WKUIDelegate {
    
    var viewModel: SettingsViewModelProtocol?
    private var webView = WKWebView()
    
//MARK: UILabel
    private var navTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._500)
        label.text = "Usage Policy"
        label.textAlignment = .center
        return label
    }()
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
        viewModel?.requestUsagePolicy()
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
        webView.navigationDelegate = self
        webView.backgroundColor = .white
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(backButton)
        view.addSubview(navTitle)
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        navTitle.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.height.equalTo(22)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
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
extension UsagePolicyController: SettingsControllerDelegate {
    func setRequest(request: URLRequest) {
        webView.load(request)
    }
}
extension UsagePolicyController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 didCommit navigation: WKNavigation!) {
//        webView.stopLoading()
    }
}
