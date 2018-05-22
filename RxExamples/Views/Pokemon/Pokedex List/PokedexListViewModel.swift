//
//  PokedexListViewModel.swift
//  RxExamples
//
//  Created by james bouker on 5/21/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxSwift
import RxCocoa

class PokedexListViewModel {
	private var pokedexList = BehaviorRelay<[PokedexListItem]>(value: [PokedexListItem]())
	struct Output {
		var pokedexList: Observable<[PokedexListItem]>
	}

	func transform() -> Output {
		return Output(pokedexList: pokedexList.asDriver().asObservable())
	}

	init() {
		PokemonAPI.fetchPokedexList(pokedexList.accept)
	}
}
