//
//  ValidationTests.swift
//  RxExamplesTests
//
//  Created by james bouker on 5/14/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxSwift
import RxTest
import XCTest
@testable import RxExamples

class ValidationTests: BaseTestCase {
	var viewModel: ValidationViewModel!
	
	override func setupViewModel() {
		viewModel = ValidationViewModel()
	}

	func createInputForUsernameAndPasswordValidationTest() -> ValidationViewModel.Input{
		let username = scheduler.createHotObservable([
			next(0, ""),
			next(10, "u"),
			next(20, "us"),
			next(30, "use"),
			next(40, "user"),
			next(50, "user1"),
			next(60, "user12"),
			]).asObservable()

		let password = scheduler.createHotObservable([
			next(0, ""),
			next(110, "p"),
			next(120, "pa"),
			next(130, "pas"),
			next(140, "pass"),
			next(150, "passw"),
			next(160, "passwo"),
			next(170, "passwor"),
			next(180, "password"),
			next(190, "password1"),
			next(200, "password1S")
			]).asObservable()

		return ValidationViewModel.Input(username: username, password: password)
	}

	func testUsernameAndPasswordValidation() {

		let input = createInputForUsernameAndPasswordValidationTest()
		let output = viewModel.transform(input: input)

		let bothOk = scheduler.record(source: output.bothOk)
		let userOk = scheduler.record(source: output.usernameOk)
		let passOk = scheduler.record(source: output.passOk)

		scheduler.start()

		let expectedUserOk = [
			next(0, false),
			next(10, false),
			next(20, false),
			next(30, false),
			next(40, false),
			next(50, false),
			next(60, true),
		]
		XCTAssertEqual(userOk.events, expectedUserOk)

		let expectedBothOk = [
			next(0, false),
			next(10, false),
			next(20, false),
			next(30, false),
			next(40, false),
			next(50, false),
			next(60, false),
			next(110, false),
			next(120, false),
			next(130, false),
			next(140, false),
			next(150, false),
			next(160, false),
			next(170, false),
			next(180, false),
			next(190, false),
			next(200, true)
		]

		let expectedPassOk = [
			next(0, false),
			next(110, false),
			next(120, false),
			next(130, false),
			next(140, false),
			next(150, false),
			next(160, false),
			next(170, false),
			next(180, false),
			next(190, false),
			next(200, true)
		]
		
		XCTAssertEqual(bothOk.events, expectedBothOk)
		XCTAssertEqual(passOk.events, expectedPassOk)
	}
}
