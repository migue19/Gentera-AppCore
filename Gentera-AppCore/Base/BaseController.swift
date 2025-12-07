//
//  BaseController.swift
//  Gentera-AppCore
//
//  Created by Miguel Mexicano Herrera on 06/12/25.
//
import UIKit
import Gentera_UI
class BaseController: UIViewController {
    private lazy var hud = ProgressHUDView()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func showHUD() {
        hud.present(on: view)
    }
    func hideHUD() {
        hud.dismiss()
    }
    @objc func backAction() {
        self.dismiss(animated: true)
    }
}

