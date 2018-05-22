//
//  PokemonAPI+Extensions.swift
//  RxExamples
//
//  Created by james bouker on 5/22/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension PokemonAPI {
	static func fetchPokedex(_ pokedex: Int, completion: @escaping (Pokedex?) -> Void) {
		request(.pokedex(id: pokedex), type: Pokedex.self, keypath: nil) { (pokedex, error) in
			guard let pokedex = pokedex, error == nil else {
				completion(nil)
				return
			}
			completion(pokedex)
		}
	}

	static func fetchPokedexList(_ completion: @escaping ([PokedexListItem]) -> Void) {
		request(.pokedexList, type: [PokedexListItem].self, keypath: "results") { (items, error) in
			guard let items = items, error == nil else {
				completion([])
				return
			}
			completion(items)
		}
	}
}

private let provider = MoyaProvider<PokemonAPI>()
private func request<D: Decodable>(_ api: PokemonAPI, type: D.Type, keypath: String?, completion: @escaping (D?, Error?) -> Void) {


	let url = (try! provider.endpoint(api).urlRequest()).url!.absoluteString
	print("Key \(url)")
	
	// Does this exist in the cache?
	// If so, expired?

	provider.request(api) { result in
		switch result {
		case .success(let response):
			do {
//				print("JSON: \((try? response.mapString()) ?? "nil")")
				let mapped = try response.map(type, atKeyPath: keypath, using: JSONDecoder(), failsOnEmptyData: false)
				completion(mapped, nil)

				// on bg thread, cache?
			} catch {
				completion(nil, error)
			}
		case .failure(let error):
			completion(nil, error)
		}
	}
}
