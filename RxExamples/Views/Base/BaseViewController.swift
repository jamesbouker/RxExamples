//
//  BaseViewController.swift
//  RxExamples
//
//  Created by james bouker on 5/10/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

	var bag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		bindViewModel()
	}

	func bindViewModel() { }
}
