//
//  BaseTestCase.swift
//  RxExamplesTests
//
//  Created by james bouker on 5/15/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

class BaseTestCase: XCTestCase {
	var bag: DisposeBag!
	var scheduler: TestScheduler!

	override func setUp() {
		super.setUp()
		bag = DisposeBag()
		scheduler = TestScheduler(initialClock: 0)
		setupViewModel()
	}

	func setupViewModel() {}
}
