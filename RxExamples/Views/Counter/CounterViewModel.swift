//
//  CounterViewModel.swift
//  RxExamples
//
//  Created by james bouker on 5/11/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxCocoa
import RxFeedback
import RxSwift

class CounterViewModel: ViewModelType {
	var bag = DisposeBag()

    struct Input {
        var plus: ControlEvent<Void>
        var minus: ControlEvent<Void>
    }

    struct Output {
        var value: Observable<String>
    }

    func transform(input: Input) -> Output {

		let text = BehaviorRelay<String>(value: "")
		let out = Output(value: text.asObservable())

        Observable.system(0,
            reduce: counterReducer,
            scheduledFeedback: bind(self) { this, state -> Bindings<CounterEvent> in
                let subs = [
                    state.map { String($0) }.bind(to: text)
                ]
                let events = [
                    input.plus.map { CounterEvent.increment },
                    input.minus.map { CounterEvent.decrement }
                ]
                return Bindings(subscriptions: subs, events: events)
        }).subscribe().disposed(by: bag)

        return out
    }
}
