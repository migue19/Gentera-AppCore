//
//  OTPViewController.swift
//  Gentera-AppCore
//
//  Created by Miguel.mexicano on 10/12/25.
//

import UIKit
import Gentera_UI

class OTPViewController: BaseController {
    // MARK: - UI
    private lazy var backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        b.tintColor = .black
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return b
    }()

    private lazy var stepView: StepView = {
        let v = StepView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setStep(current: 2, total: 3)
        v.setProgress(0.66, animated: false)
        v.configure(trackColor: UIColor(white: 0.95, alpha: 1), progressColor: .black)
        return v
    }()

    private lazy var avatarView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "shield")
        iv.tintColor = .darkGray
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var titleLabel: CustomLabel = {
        let l = CustomLabel(text: "¡Hola, Alejandra!", style: .title)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var subtitleLabel: CustomLabel = {
        let l = CustomLabel(text: "Ingresa el código de 6 dígitos que hemos enviado al número celular con el que te registraste por primera vez", style: .subtitle)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()

    private lazy var otpView: OTPView = {
        let v = OTPView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var timerLabel: CustomLabel = {
        let l = CustomLabel(text: "Expira en 05:00", style: .subtitle)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var validateButton: CustomButton = {
        let btn = CustomButton(title: "Validar Código", style: .primary)
        btn.setDisabled(true)
        btn.addTarget(self, action: #selector(validateTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private lazy var resendButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Reenviar código", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)
        return b
    }()

    // Para detectar entrada y habilitar el botón Validar, añadimos un pequeño textField invisible
    // que recibirá el input desde el teclado. Esto es una solución segura si el componente `OTPView`
    // no expone callbacks directamente.
    private lazy var hiddenTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.isHidden = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // Small helper to wire the protocol methods into a single call (pattern used elsewhere)
    func setupUI() {
        setupView()
        addSubviews()
        setupConstraints()
    }

    // MARK: - Actions
    @objc func validateTapped() {
        // Aquí se debería obtener el código directamente desde `otpView` si el componente lo expone.
        // Como medida neutral, tomamos el valor del `hiddenTextField`.
        let code = hiddenTextField.text ?? ""
        print("Validar código: \(code)")
        showHUD()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.hideHUD()
            // Lógica posterior a validación
        }
    }

    @objc func resendTapped() {
        print("Reenviar código tapped")
        // Implementar reenvío real. Aquí simplemente reiniciamos el temporizador de ejemplo.
        timerLabel.text = "Expira en 05:00"
    }

    @objc func textFieldDidChange(_ tf: UITextField) {
        // Habilitamos el botón cuando tenemos 6 dígitos (asumimos OTP de 6).
        let hasSix = (tf.text ?? "").count >= 6
        validateButton.setDisabled(!hasSix)
    }
}

// MARK: - Layout
extension OTPViewController: GeneralSetupViewProtocol {
    func setupView() {
        view.backgroundColor = .white
    }

    func addSubviews() {
        view.addSubviews(backButton, stepView)
        view.addSubviews(avatarView, titleLabel, subtitleLabel)
        view.addSubviews(otpView, timerLabel, validateButton, resendButton, hiddenTextField)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            stepView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12),
            stepView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stepView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            avatarView.topAnchor.constraint(equalTo: stepView.bottomAnchor, constant: 8),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 72),
            avatarView.heightAnchor.constraint(equalToConstant: 72),

            titleLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            otpView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            otpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            otpView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 40),
            otpView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40),
            // Intentamos dar una altura razonable al control OTP
            otpView.heightAnchor.constraint(equalToConstant: 48),

            timerLabel.topAnchor.constraint(equalTo: otpView.bottomAnchor, constant: 12),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            validateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            validateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            validateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            resendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resendButton.bottomAnchor.constraint(equalTo: validateButton.topAnchor, constant: -24),

            hiddenTextField.topAnchor.constraint(equalTo: otpView.topAnchor),
            hiddenTextField.leadingAnchor.constraint(equalTo: otpView.leadingAnchor),
            hiddenTextField.trailingAnchor.constraint(equalTo: otpView.trailingAnchor),
            hiddenTextField.heightAnchor.constraint(equalTo: otpView.heightAnchor)
        ])
    }
}
