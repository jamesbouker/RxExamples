//
//  CounterFeedback.swift
//  RxExamples
//
//  Created by james bouker on 5/11/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import Foundation
import RxCocoa
import RxFeedback
import RxSwift
import UIKit

typealias CounterState = Int

enum CounterEvent {
    case increment
    case decrement
}

func counterReducer(state: CounterState, event: CounterEvent) -> CounterState {
    switch event {
    case .increment: return state + 1
    case .decrement: return state - 1
    }
}
