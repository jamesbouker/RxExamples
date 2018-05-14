//
//  ValidationViewModel.swift
//  RxExamples
//
//  Created by james bouker on 5/10/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ValidationViewModel: ViewModelType {
    struct Input {
        var username: Observable<String>
        var password: Observable<String>
    }

    struct Output {
        var passLength: Observable<UIColor>
        var passNumber: Observable<UIColor>
        var passUpper: Observable<UIColor>
        var passLower: Observable<UIColor>
        var passOk: Observable<Bool>
        var usernameOk: Observable<Bool>
        var bothOk: Observable<Bool>
    }

    func transform(input: Input) -> Output {
        let usernameOk = input.username.map { $0.count > 5 }

		func containsNum(_ str: String) -> Bool { return str.rangeOfCharacter(from: .decimalDigits) != nil }
		func containsUpper(_ str: String) -> Bool { return str.rangeOfCharacter(from: .uppercaseLetters) != nil }
		func containsLower(_ str: String) -> Bool { return str.rangeOfCharacter(from: .lowercaseLetters) != nil }

        let pass = input.password
        let passLength = pass.map { $0.count > 8 }
        let passNumber = pass.map(containsNum)
        let passUpper = pass.map(containsUpper)
        let passLower = pass.map(containsLower)

        let passOk = pass.map { $0.count > 8 && containsNum($0) && containsUpper($0) && containsLower($0) }
        let bothOk = Observable.combineLatest(usernameOk, passOk) { $0 && $1 }
        return Output(passLength: passLength.color,
                      passNumber: passNumber.color,
                      passUpper: passUpper.color,
                      passLower: passLower.color,
                      passOk: passOk,
                      usernameOk: usernameOk,
                      bothOk: bothOk)
    }
}

private extension Observable where Element == Bool {
    var color: Observable<UIColor> {
        return map { $0 ? UIColor.green : UIColor.red }
    }
}
