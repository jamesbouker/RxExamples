//
//  Observable.swift
//  
//
//  Created by james bouker on 5/11/18.
//

import RxFeedback
import RxSwift

extension ObservableType where Self.E == Any {

	public static func system<State, Event>(_ initialState: State,
											reduce: @escaping (State, Event) -> State,
											scheduledFeedback: (RxFeedback.ObservableSchedulerContext<State>)
		-> RxSwift.Observable<Event>...) -> RxSwift.Observable<State> {

		return Observable.system(
			initialState: initialState,
			reduce: reduce,
			scheduler: MainScheduler.instance,
			scheduledFeedback: scheduledFeedback)
	}
}
