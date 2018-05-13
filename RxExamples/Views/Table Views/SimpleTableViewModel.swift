//
//  SimpleTableViewModel.swift
//  RxExamples
//
//  Created by james bouker on 5/13/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import Foundation
import RxSwift

class SimpleTableViewModel: ViewModelType {
    struct Input {
    }

    struct Output {
        var items: Observable<[String]>
    }

    func transform(input _: Input) -> Output {
        let items = Observable.just((0 ... 100).map(String.init))
        return Output(items: items)
    }
}
