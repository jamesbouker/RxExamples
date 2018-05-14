//
//  AdderTests.swift
//  RxExamplesTests
//
//  Created by james bouker on 5/10/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import RxBlocking
import RxTest

@testable import RxExamples

class AdderTests: XCTestCase {

	var bag: DisposeBag!
	var viewModel: AdderViewModel!
	var testScheduler: TestScheduler!

	override func setUp() {
		super.setUp()
		bag = DisposeBag()
		viewModel = AdderViewModel()
		testScheduler = TestScheduler(initialClock: 0)
	}

	func testMath() {
		let text1 = testScheduler.createHotObservable([next(1, "1"), next(100, "2")]).asObservable()
		let text2 = testScheduler.createHotObservable([next(2, "2"), next(200, "-2"), next(500, "0")]).asObservable()
		let text3 = testScheduler.createHotObservable([next(3, "3"), next(300, "10"), next(400, "-100")]).asObservable()
		let numbers = [text1, text2, text3]
		let input = AdderViewModel.Input(numbers: numbers)
		let output = viewModel.transform(input: input)

		let observer = testScheduler.createObserver(String.self)
		output.solution.bind(to: observer).disposed(by: bag)
		testScheduler.start()

		let expectedEvents = [
			next(3, "6"),
			next(100, "7"),
			next(200, "3"),
			next(300, "10"),
			next(400, "-100"),
			next(500, "-98")
		]
		XCTAssertEqual(observer.events, expectedEvents)
	}
}
