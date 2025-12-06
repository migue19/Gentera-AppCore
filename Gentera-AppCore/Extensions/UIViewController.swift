//
//  UIViewController.swift
//  Gentera-AppCore
//
//  Created by Miguel Mexicano Herrera on 06/12/25.
//
import UIKit
extension UIViewController {
    func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    /// Funcion para ocultar el teclado al tocar en cualquier parte de la pantalla.
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
