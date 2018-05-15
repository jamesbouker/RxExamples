//
//  TestScheduler+Extensions.swift
//  RxExamplesTests
//
//  Created by james bouker on 5/15/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxTest
import RxSwift

extension TestScheduler {
	/**
	Builds testable observer for s specific observable sequence, binds it's results and sets up disposal.

	- parameter source: Observable sequence to observe.
	- returns: Observer that records all events for observable sequence.
	*/
	func record<O: ObservableConvertibleType>(source: O) -> TestableObserver<O.E> {
		let observer = self.createObserver(O.E.self)
		let disposable = source.asObservable().bind(to: observer)
		self.scheduleAt(100000) {
			disposable.dispose()
		}
		return observer
	}
}
