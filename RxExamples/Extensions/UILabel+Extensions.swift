//
//  UILabel+Extensions.swift
//  RxExamples
//
//  Created by james bouker on 5/10/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxSwift
import UIKit

extension UILabel {
    public var rx_textColor: AnyObserver<UIColor> {
        return AnyObserver { [weak self] event in
            MainScheduler.ensureExecutingOnScheduler()
            switch event {
            case let .next(value): self?.textColor = value
            default: break
            }
        }
    }
}
