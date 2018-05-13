//
//  SimpleTableViewModel.swift
//  RxExamples
//
//  Created by james bouker on 5/13/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SimpleTableViewModel: ViewModelType {
    struct Input {
		var itemSelected: ControlEvent<IndexPath>
		var accessorySelected: ControlEvent<IndexPath>
    }

    struct Output {
        var items: Observable<[String]>
		var tapped: Observable<(IndexPath, String)>
    }

    func transform(input: Input) -> Output {
        let items = Observable.just((0 ... 100).map(String.init))
		let selected = Observable.of(input.itemSelected, input.accessorySelected).merge().map { ($0, String($0.item)) }
		return Output(items: items, tapped: selected)
    }
}
