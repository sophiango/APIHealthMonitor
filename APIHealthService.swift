//
//  APIHealthService.swift
//  APIHealthMonitor
//
//  Created by Sophia Ngo on 1/20/26.
//

import Foundation

struct APIHealthResult {
	let statusCode: Int
	let responseTimeMs: Int
}

protocol APIHealthChecking {
	func check(url: URL) async throws -> APIHealthResult
}

struct APIHealthService: APIHealthChecking {

	func check(url: URL) async throws -> APIHealthResult {
		let startTime = Date()

		let (_, response) = try await URLSession.shared.data(from: url)

		let duration = Date().timeIntervalSince(startTime) * 1000

		guard let httpResponse = response as? HTTPURLResponse else {
			throw URLError(.badServerResponse)
		}

		return APIHealthResult(
			statusCode: httpResponse.statusCode,
			responseTimeMs: Int(duration)
		)
	}
}
