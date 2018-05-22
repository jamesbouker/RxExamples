//
//  PokedexViewModel.swift
//  RxExamples
//
//  Created by james bouker on 5/22/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxSwift
import RxCocoa

class PokedexViewModel {
	private var species = BehaviorRelay<[Species]>(value: [Species]())
	private var title = BehaviorRelay<String>(value: "")

	struct Output {
		var species: Observable<[Species]>
		var title: Observable<String>
	}

	func transform() -> Output {
		return Output(species: species.asDriver().asObservable(),
					  title: title.asDriver().asObservable())
	}

	init(_ id: Int) {
		PokemonAPI.fetchPokedex(id) { [weak self] (pokedex) in
			guard let pokedex = pokedex else { return }

			self?.title.accept(pokedex.name)
			let species = pokedex.pokemonEntries.map { $0.pokemonSpecies }
			self?.species.accept(species)
		}
	}
}

