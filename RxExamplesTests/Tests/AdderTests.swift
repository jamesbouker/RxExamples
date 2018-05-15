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

class AdderTests: BaseTestCase {
	var viewModel: AdderViewModel!

	override func setupViewModel() {
		viewModel = AdderViewModel()
	}

	func testMath() {
		let text1 = scheduler.createHotObservable([next(1, "1"), next(100, "2")]).asObservable()
		let text2 = scheduler.createHotObservable([next(2, "2"), next(200, "-2"), next(500, "0")]).asObservable()
		let text3 = scheduler.createHotObservable([next(3, "3"), next(300, "10"), next(400, "-100")]).asObservable()
		let numbers = [text1, text2, text3]
		let input = AdderViewModel.Input(numbers: numbers)
		let output = viewModel.transform(input: input)

		let observer = scheduler.record(source: output.solution)
		scheduler.start()

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
