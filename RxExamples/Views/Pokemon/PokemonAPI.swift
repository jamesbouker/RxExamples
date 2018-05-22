//
//  PokemonAPI.swift
//  RxExamples
//
//  Created by james bouker on 5/21/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import Foundation
import Moya

enum PokemonAPI {
	case pokedexList
	case pokedex(id: Int)
}

extension PokemonAPI: TargetType {
	var baseURL: URL {
		return URL(string: "https://pokeapi.co/api/v2")!
	}

	var path: String {
		switch self {
		case .pokedexList: return "/pokedex"
		case .pokedex(let id): return "/pokedex/\(id)"
		}
	}

	var method: Moya.Method {
		return .get
	}

	var sampleData: Data {
		return "Nothing".data(using: .utf8)!
	}

	var task: Task {
		switch self {
		case .pokedexList, .pokedex: return .requestPlain
		}
	}

	var headers: [String : String]? {
		return ["Content-type": "application/json"]
	}
}
