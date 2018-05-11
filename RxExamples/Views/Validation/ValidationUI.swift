//
//  ValidationUI.swift
//  RxExamples
//
//  Created by james bouker on 5/10/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import UIKit

class ValidationUI: NSObject {
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var usernameLength: UILabel!

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordLength: UILabel!
    @IBOutlet var passwordContainsNumber: UILabel!
    @IBOutlet var passwordContainsUppercase: UILabel!
    @IBOutlet var passwordContainsLowercase: UILabel!

    @IBOutlet var signupButton: UIButton!

    var passwordLabels: [UILabel] {
        return [passwordLength, passwordContainsNumber, passwordContainsLowercase, passwordContainsUppercase]
    }
}
