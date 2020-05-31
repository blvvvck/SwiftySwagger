//
//  BaseTargetType.swift
//  Library-ios
//
//  Created by Rinat Mukhammetzyanov on 20/11/2019.
//  Copyright © 2019 TEKHNOKRATIYA. All rights reserved.
//

struct Pet: Codable {

	let id: Int

	let name: String

	let status: String

	let tags: [Tag]

}
