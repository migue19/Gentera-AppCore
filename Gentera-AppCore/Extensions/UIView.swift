//
//  UIView.swift
//  Gentera-AppCore
//
//  Created by Miguel Mexicano Herrera on 05/12/25.
//
import UIKit
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
