//
//  ValidationTests.swift
//  RxExamplesTests
//
//  Created by james bouker on 5/14/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxBlocking
import RxTest
import XCTest
@testable import RxExamples

class ValidationTests: XCTestCase {

	var viewModel: ValidationViewModel!
	var scheduler: TestScheduler!
	var bag: DisposeBag!

	override func setUp() {
		super.setUp()
		bag = DisposeBag()
		viewModel = ValidationViewModel()
		scheduler = TestScheduler(initialClock: 0)
	}

	func testSimple() {

		let username = scheduler.createHotObservable([
			next(10, "u"),
			next(20, "s"),
			next(30, "e"),
			next(40, "r"),
			next(50, "r"),
		]).asObservable()

		let password = scheduler.createHotObservable([
			next(10, ""),
			next(110, "p"),
			next(120, "a"),
			next(130, "s"),
			next(140, "s"),
			next(150, "w"),
			next(160, "o"),
			next(170, "r"),
			next(180, "d")
		]).asObservable()
		let input = ValidationViewModel.Input(username: username, password: password)
		let output = viewModel.transform(input: input)

		let bothOk = scheduler.createObserver(Bool.self)
		output.bothOk.bind(to: bothOk).disposed(by: bag)
		scheduler.start()

		let expectedBothOk = [
			next(10, false),
			next(20, false),
			next(30, false),
			next(40, false),
			next(50, false),
			next(110, false),
			next(120, false),
			next(130, false),
			next(140, false),
			next(150, false),
			next(160, false),
			next(170, false),
			next(180, false)
		]
		XCTAssertEqual(bothOk.events, expectedBothOk)
	}
}
