//
//  CounterViewController.swift
//  RxExamples
//
//  Created by james bouker on 5/11/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class CounterViewController: BaseViewController {
    @IBOutlet var ui: CounterUI!
    var viewModel = CounterViewModel()

    override func bindViewModel() {
        let inputs = CounterViewModel.Input(plus: ui.plus.rx.tap, minus: ui.minus.rx.tap)
        let output = viewModel.transform(input: inputs)
        output.value.bind(to: ui.label.rx.text).disposed(by: bag)
    }
}
