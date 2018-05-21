//
//  PokemonViewModel.swift
//  RxExamples
//
//  Created by james bouker on 5/21/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxSwift
import RxCocoa

class PokemonViewModel: ViewModelType {

	// MARK: Rx

	var bag = DisposeBag()
	var pokedexList = BehaviorRelay<[[String: String]]>(value: [[String: String]]())

	struct Input { }
	struct Output {
		var pokedexList: Observable<[[String: String]]>
	}

	func transform(input: Input) -> Output {
		return Output(pokedexList: pokedexList.asDriver().asObservable())
	}

	init() {
		fetchPokemonList()
	}
}

// MARK: Functions

extension PokemonViewModel {
	func fetchPokemonList() {
		provider.rx.request(.pokedexList).subscribe { [weak self] event in
			switch event {
			case .success(let response):
				print("Got response")
				let data = try? response.mapJSON()
				guard let json = data as? [String: Any],
					let results = json["results"] as? [[String: String]] else { return }
				self?.pokedexList.accept(results)
			case .error(let error): print(error.localizedDescription)
			}
		}.disposed(by: bag)
	}
}
