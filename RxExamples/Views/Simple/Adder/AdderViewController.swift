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
    @IBOutlet var ui: AdderUI!
    var viewModel = AdderViewModel()

    override func bindViewModel() {
        let input = AdderViewModel.Input(numbers: fields.map { $0.rx.text.orEmpty.asObservable() })
        let output = viewModel.transform(input: input)
        output.solution.bind(to: ui.solution.rx.text).disposed(by: bag)
    }
}
