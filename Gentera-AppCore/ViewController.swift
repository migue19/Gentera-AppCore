//
//  ViewController.swift
//  Gentera-AppCore
//
//  Created by Miguel.mexicano on 03/12/25.
//

import UIKit
import Gentera_UI
class ViewController: UIViewController {
    lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(text: "Logo", style: .title)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var openAccountButton: CustomButton = {
        let button = CustomButton(title: "Abrir una cuenta", style: .primary)
        button.addTarget(self, action: #selector(openAccountButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var amClientButton: CustomButton = {
        let button = CustomButton(title: "Ya soy cliente", style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    @objc func openAccountButtonTapped() {
        let openAccountVC = OpenAccountVC()
        openAccountVC.modalPresentationStyle = .fullScreen
        openAccountVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(openAccountVC, animated: true, completion: nil)
    }
}
extension ViewController: GeneralSetupViewProtocol {
    func setupView() {
        view.backgroundColor = .gray
    }
    func addSubviews() {
        view.addSubviews(titleLabel, openAccountButton, amClientButton)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amClientButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            amClientButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amClientButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            openAccountButton.bottomAnchor.constraint(equalTo: amClientButton.topAnchor, constant: -16),
            openAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            openAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
