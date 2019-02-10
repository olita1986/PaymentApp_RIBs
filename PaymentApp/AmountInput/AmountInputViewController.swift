//
//  AmountInputViewController.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol AmountInputPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func inputAmount()
    func textFieldDidChange(text: String)
}

final class AmountInputViewController: UIViewController, AmountInputPresentable, AmountInputViewControllable {

    weak var listener: AmountInputPresentableListener?
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!

    init() {
        super.init(nibName: "AmountInputViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Amount Input"
        setupViews()
    }

    func setupViews() {
        setupGestureRecognizer()
        setupAmountTextField()
        setupContinueButton()
    }

    func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func setupAmountTextField() {
        amountTextField.delegate = self
        amountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    func setupContinueButton() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = .gray
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        listener?.textFieldDidChange(text: text)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func buttonPressed(_ sender: Any) {
        listener?.inputAmount()
    }

    func presentEnabledContinueButton() {
        continueButton.isEnabled = true
        continueButton.backgroundColor = UIColor(red: 0.457, green: 0.819, blue: 1, alpha: 1)
    }

    func presentDisabledContinueButton() {
        setupContinueButton()
    }
}

extension AmountInputViewController: UITextFieldDelegate {

}
