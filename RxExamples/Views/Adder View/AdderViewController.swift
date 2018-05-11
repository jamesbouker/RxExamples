//
//  AdderViewController.swift
//  Adder
//
//  Created by james bouker on 5/9/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AdderViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet weak var number1: UITextField!
	@IBOutlet weak var number2: UITextField!
	@IBOutlet weak var number3: UITextField!
	@IBOutlet weak var solution: UILabel!

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
	var bag = DisposeBag()

	func bindViewModel() {
		let input = AdderViewModel.Input(numbers: fieldObservers)
		let output = viewModel.transform(input: input)
		output.solution.bind(to: solutionBinder).disposed(by: bag)
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		bindViewModel()
	}

	// MARK: - Event Listeners
	@IBAction func hideKeyboard() {
		fields.forEach { $0.resignFirstResponder() }
	}
}
