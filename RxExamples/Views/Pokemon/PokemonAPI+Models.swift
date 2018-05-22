//
//  PokemonAPI+Models.swift
//  RxExamples
//
//  Created by james bouker on 5/22/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import Foundation

struct PokedexListItem: Codable {
	var name: String
	var url: String
}

struct Pokedex: Codable {
	let name: String
	let pokemonEntries: [PokemonEntry]

	enum CodingKeys: String, CodingKey {
		case name
		case pokemonEntries = "pokemon_entries"
	}
}

struct PokemonEntry: Codable {
	let entryNumber: Int
	let pokemonSpecies: Species

	enum CodingKeys: String, CodingKey {
		case entryNumber = "entry_number"
		case pokemonSpecies = "pokemon_species"
	}
}

struct Species: Codable {
	let url, name: String
}
