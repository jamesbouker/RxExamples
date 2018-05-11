//
//  ViewModelType.swift
//  Adder
//
//  Created by james bouker on 5/10/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import Foundation

protocol ViewModelType {
	associatedtype Input
	associatedtype Output

	func transform(input: Input) -> Output
}
