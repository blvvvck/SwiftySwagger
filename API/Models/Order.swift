//
//  BaseTargetType.swift
//  Library-ios
//
//  Created by Rinat Mukhammetzyanov on 20/11/2019.
//  Copyright © 2019 TEKHNOKRATIYA. All rights reserved.
//

struct Order: Codable {

	let id: Int

	let petId: Int

	let quantity: Int

	let shipDate: String

	let status: String

}
