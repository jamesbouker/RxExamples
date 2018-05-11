//
//  AdderViewController.swift
//  Adder
//
//  Created by james bouker on 5/9/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class AdderViewController: BaseViewController {

    // MARK: - Outlets

    @IBOutlet var number1: UITextField!
    @IBOutlet var number2: UITextField!
    @IBOutlet var number3: UITextField!
    @IBOutlet var solution: UILabel!

    // MARK: - Rx

    var fields: [UITextField] {
        return [number1, number2, number3]
    }

    var fieldObservers: [ControlProperty<String>] {
        return fields.map { $0.rx.text.orEmpty }
    }

    var solutionBinder: Binder<String?> {
        return solution.rx.text
    }

    var viewModel = AdderViewModel()

	override func bindViewModel() {
        let input = AdderViewModel.Input(numbers: fieldObservers)
        let output = viewModel.transform(input: input)
        output.solution.bind(to: solutionBinder).disposed(by: bag)
    }

    // MARK: - Event Listeners

    @IBAction func hideKeyboard() {
        fields.forEach { $0.resignFirstResponder() }
    }
}
