//
//  OpenAccountVC.swift
//  Gentera-AppCore
//
//  Created by Miguel Mexicano Herrera on 05/12/25.
//
import UIKit
import Gentera_UI

class OpenAccountVC: UIViewController {
    // Top controls
    private lazy var backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        b.tintColor = .black
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    private lazy var helpButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        b.tintColor = .black
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    private lazy var stepView: StepView = {
        let v = StepView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setStep(current: 1, total: 3)
        v.setProgress(0.35, animated: false)
        v.progressHeight = 8
        v.configure(trackColor: UIColor(white: 0.95, alpha: 1), progressColor: .black)
        return v
    }()
    // Avatar
    private lazy var avatarView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.circle")
        iv.tintColor = .darkGray
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // Labels
    private lazy var titleLabel: CustomLabel = {
        let l = CustomLabel(text: "Ingresa tus datos", style: .title)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    // Use a plain UILabel for subtitle to avoid relying on unknown CustomLabel styles
    private lazy var subtitleLabel: CustomLabel = {
        let l = CustomLabel(text: "Necesitamos verificar tu identidad", style: .subtitle)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    // Fields
    private lazy var phoneField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Ingresa tu teléfono", type: .phone, title: "Teléfono")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private lazy var idField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Ingresa ID o escanea con la cámara", type: .idCard, title: "ID Cliente o Número de Tarjeta")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private lazy var dateField: CustomTextField = {
        let tf = CustomTextField(placeholder: "DD/MM/AAAA", type: .date, title: "Fecha de Nacimiento")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private lazy var termsView: TermsView = {
        let v = TermsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTermsText(mainText: "He leído y acepto los ", linkText: "Términos y Condiciones")
        v.onToggle = { print("v1 toggled: \($0)") }
        v.onTermsTap = { print("Terms tapped") }
        return v
    }()
    
    // Continue button
    private lazy var continueButton: CustomButton = {
        let btn = CustomButton(title: "Continuar", style: .primary)
        btn.setDisabled(true)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
}
extension OpenAccountVC: GeneralSetupViewProtocol {
    func setupView() {
        view.backgroundColor = .white
    }
    func addSubviews() {
        view.addSubviews(backButton, helpButton, stepView)

        view.addSubviews(avatarView, titleLabel, subtitleLabel,
                         phoneField, idField, dateField,
                         termsView, continueButton)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Top bar
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            helpButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            helpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Progress
            stepView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12),
            stepView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stepView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Avatar
            avatarView.topAnchor.constraint(equalTo: stepView.bottomAnchor, constant: 8),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 72),
            avatarView.heightAnchor.constraint(equalToConstant: 72),

            // Title and subtitle
            titleLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Fields
            phoneField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            phoneField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //phoneField.heightAnchor.constraint(equalToConstant: 48),

            idField.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 12),
            idField.leadingAnchor.constraint(equalTo: phoneField.leadingAnchor),
            idField.trailingAnchor.constraint(equalTo: phoneField.trailingAnchor),
            idField.heightAnchor.constraint(equalTo: phoneField.heightAnchor),

            dateField.topAnchor.constraint(equalTo: idField.bottomAnchor, constant: 12),
            dateField.leadingAnchor.constraint(equalTo: phoneField.leadingAnchor),
            dateField.trailingAnchor.constraint(equalTo: phoneField.trailingAnchor),
            dateField.heightAnchor.constraint(equalTo: phoneField.heightAnchor),

            termsView.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 12),
            termsView.leadingAnchor.constraint(equalTo: phoneField.leadingAnchor),
            termsView.trailingAnchor.constraint(equalTo: phoneField.trailingAnchor),
            termsView.heightAnchor.constraint(equalTo: phoneField.heightAnchor),
            
            // Continue
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

@objc extension OpenAccountVC {
}
