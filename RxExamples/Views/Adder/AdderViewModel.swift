//
//  AdderViewModel.swift
//  Adder
//
//  Created by james bouker on 5/10/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class AdderViewModel: ViewModelType {
    struct Input {
        var numbers: [ControlProperty<String>]
    }

    struct Output {
        var solution: Observable<String>
    }

    func transform(input: Input) -> Output {
        let solution = Observable.combineLatest(input.numbers) { latest in
            latest.reduce(0) { $0 + (Int($1) ?? 0) }
        }
        .map { String($0) }
        return Output(solution: solution)
    }
}
