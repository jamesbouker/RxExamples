//
//  ValidationViewController.swift
//  RxExamples
//
//  Created by james bouker on 5/10/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ValidationViewController: BaseViewController {
    @IBOutlet var ui: ValidationUI!
    var viewModel = ValidationViewModel()

    override func bindViewModel() {
        let input = ValidationViewModel.Input(username: ui.usernameTextField.rx.text.orEmpty,
                                              password: ui.passwordTextField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)

        output.usernameOk.bind(to: ui.usernameLength.rx.isHidden).disposed(by: bag)
        output.bothOk.bind(to: ui.signupButton.rx.isEnabled).disposed(by: bag)
        output.bothOk.map { $0 ? UIColor.black : UIColor.lightGray }
            .bind(to: ui.signupButton.rx_backgroundColor).disposed(by: bag)

        output.passOk.bind { [weak self] hidden in
            self?.ui.passwordLabels.forEach { $0.isHidden = hidden }
        }.disposed(by: bag)

        output.passLength.bind(to: ui.passwordLength.rx_textColor).disposed(by: bag)
        output.passNumber.bind(to: ui.passwordContainsNumber.rx_textColor).disposed(by: bag)
        output.passUpper.bind(to: ui.passwordContainsUppercase.rx_textColor).disposed(by: bag)
        output.passLower.bind(to: ui.passwordContainsLowercase.rx_textColor).disposed(by: bag)

        ui.signupButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.signup()
        }).disposed(by: bag)
    }

    func signup() {
        // Just showing an alert...
        let alert = UIAlertController(title: "Signed Up", message: "Congratulations!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true, completion: nil)
    }
}
