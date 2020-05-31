//
//  MoyaGenerator.swift
//  ArmatureTests
//
//  Created by Мухамметзянов Ринат Зиннурович on 30.05.2020.
//

import Foundation
import StencilSwiftKit
import Stencil
import PathKit

class DefaultGenerator: Generator {
	func generate(with swagger: Swagger, path: Path, templateName: String?) {

		let modelsForGenerate = generateTemplateModel(swagger: swagger, path: path, templateName: templateName)

		if let templateName = templateName {
			switch templateName {
			case "Moya":
				generateBaseTargetType(swagger: swagger, path: path)
				writeMoyaTemplate(modelsForGenerate: modelsForGenerate, path: path)

			case "URLSession":
				URLSessionFileWriter().writeBaseFiles(path: path)
				generateBaseEndPointType(swagger: swagger, path: path)
				writeURLSessionTemplate(modelsForGenerate: modelsForGenerate, path: path)

			case "Alamofire":
				print("ALAMOFIRE")
				
			default:
				writeMoyaTemplate(modelsForGenerate: modelsForGenerate, path: path)
			}
		} else {
			writeMoyaTemplate(modelsForGenerate: modelsForGenerate, path: path)
		}
	}

	private func writeURLSessionTemplate(modelsForGenerate: [String: [RequestToWrite]], path:Path) {
		try? FileManager.default.createDirectory(atPath: path.appending("API").string, withIntermediateDirectories: false, attributes: nil)
		try? FileManager.default.createDirectory(atPath: path.appending("API/Endpoint").string, withIntermediateDirectories: false, attributes: nil)
		try? FileManager.default.createDirectory(atPath: path.appending("API/Services").string, withIntermediateDirectories: false, attributes: nil)

		modelsForGenerate.forEach { (tag, requests) in
			let context = [
				"models": requests,
				"tag": tag.firstCapitalized
			] as [String : Any]

			let ext = Extension()
			ext.registerStencilSwiftExtensions()
			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]), extensions: [ext], templateClass: StencilSwiftTemplate.self)

			do {
				let rendered = try environment.renderTemplate(name: "URLSessionAPI.stencil", context: context)
				let path = path.appending("API/Endpoint/\(tag.firstCapitalized)API.swift")

				DefaultFileWriter.write(sourceCode: rendered, path: path)
			} catch {
				DefaultReporter.report(info: "Incorrect template")
			}
		}

		modelsForGenerate.forEach { (tag, requests) in
			let context = [
				"models": requests,
				"tag": tag.firstCapitalized
			] as [String : Any]

			let ext = Extension()
			ext.registerStencilSwiftExtensions()
			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]), extensions: [ext], templateClass: StencilSwiftTemplate.self)

			do {
				let rendered = try environment.renderTemplate(name: "URLSessionService.stencil", context: context)
				let path = path.appending("API/Services/\(tag.firstCapitalized)Service.swift")

				DefaultFileWriter.write(sourceCode: rendered, path: path)
			} catch {
				DefaultReporter.report(info: "Incorrect template")
			}
		}

	}

	private func writeMoyaTemplate(modelsForGenerate: [String: [RequestToWrite]], path: Path) {
		try? FileManager.default.createDirectory(atPath: path.appending("API").string, withIntermediateDirectories: false, attributes: nil)
		try? FileManager.default.createDirectory(atPath: path.appending("API/Providers").string, withIntermediateDirectories: false, attributes: nil)
		try? FileManager.default.createDirectory(atPath: path.appending("API/Services").string, withIntermediateDirectories: false, attributes: nil)


		modelsForGenerate.forEach { (tag, requests) in
			let context = [
				"models": requests,
				"tag": tag.firstCapitalized
			] as [String : Any]

			let ext = Extension()
			ext.registerStencilSwiftExtensions()
			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]), extensions: [ext], templateClass: StencilSwiftTemplate.self)
//			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]))

			do {
				let rendered = try environment.renderTemplate(name: "MoyaAPI.stencil", context: context)
				let path = path.appending("API/Providers/\(tag.firstCapitalized)Provider.swift")

				DefaultFileWriter.write(sourceCode: rendered, path: path)
			} catch {
				DefaultReporter.report(info: "Incorrect template")
			}

//			let rendered = try! environment.renderTemplate(name: "MoyaAPI.stencil", context: context)
//
//			let path = path.appending("API/Providers/\(tag.firstCapitalized)Provider.swift")
//
////			print(rendered)
//			try? path.write(rendered, encoding: .utf8)
		}

		modelsForGenerate.forEach { (tag, requests) in
			let context = [
				"models": requests,
				"tag": tag.firstCapitalized
			] as [String : Any]

			let ext = Extension()
			ext.registerStencilSwiftExtensions()
			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]), extensions: [ext], templateClass: StencilSwiftTemplate.self)
//			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]))

			do {
				let rendered = try environment.renderTemplate(name: "MoyaServices.stencil", context: context)
				let path = path.appending("API/Services/\(tag.firstCapitalized)Service.swift")

				DefaultFileWriter.write(sourceCode: rendered, path: path)
			} catch {
				DefaultReporter.report(info: "Incorrect template")
			}

//			let rendered = try! environment.renderTemplate(name: "MoyaServices.stencil", context: context)
//
//			let path = path.appending("API/Services/\(tag.firstCapitalized)Service.swift")
//
//			try? path.write(rendered, encoding: .utf8)
		}
	}

	private func generateTemplateModel(swagger: Swagger, path: Path, templateName: String?) -> [String: [RequestToWrite]] {
		var taggedRequest = [String: [RequestToWrite]]()
		var requests = [RequestToWrite]()

		swagger.spec.paths.forEach({ (stringPath, path) in
			if let getOperation = path.value?.get {
				let request = RequestToWrite()
				request.url = stringPath
				request.name = getOperation.identifier
				request.method = "get"
				request.createParameters(from: getOperation)
				request.createRawParameters()
				request.createRawParametersWithoutType()

				request.updateURLToMoya()

				request.checkResponse(with: getOperation)

				requests.append(request)

				let tag = getOperation.tags?.first ?? "UnknownTag"

				if var tagged = taggedRequest[tag] {
					tagged.append(request)
					taggedRequest.updateValue(tagged, forKey: tag)
				} else {
					taggedRequest.updateValue([request], forKey: tag)
				}
			}

			if let postOperation = path.value?.post {
				let request = RequestToWrite()
				request.url = stringPath

				request.name = postOperation.identifier
				request.method = "post"

				request.checkRequestBody(with: postOperation)
				request.createParameters(from: postOperation)
				request.createRawParameters()
				request.createRawParametersWithoutType()
				request.updateURLToMoya()
				request.checkResponse(with: postOperation)

				requests.append(request)

				let tag = postOperation.tags?.first ?? "UnknownTag"

				if var tagged = taggedRequest[tag] {
					tagged.append(request)
					taggedRequest.updateValue(tagged, forKey: tag)
				} else {
					taggedRequest.updateValue([request], forKey: tag)
				}
			}

			if let putOperation = path.value?.put {
				let request = RequestToWrite()
				request.url = stringPath

				request.name = putOperation.identifier
				request.method = "put"

				request.checkRequestBody(with: putOperation)
				request.createParameters(from: putOperation)
				request.createRawParameters()
				request.createRawParametersWithoutType()
				request.updateURLToMoya()
				request.checkResponse(with: putOperation)

				requests.append(request)

				let tag = putOperation.tags?.first ?? "UnknownTag"

				if var tagged = taggedRequest[tag] {
					tagged.append(request)
					taggedRequest.updateValue(tagged, forKey: tag)
				} else {
					taggedRequest.updateValue([request], forKey: tag)
				}
			}
		})

		return taggedRequest
//
//		try? FileManager.default.createDirectory(atPath: path.appending("API").string, withIntermediateDirectories: false, attributes: nil)
//		try? FileManager.default.createDirectory(atPath: path.appending("API/Providers").string, withIntermediateDirectories: false, attributes: nil)
//		try? FileManager.default.createDirectory(atPath: path.appending("API/Services").string, withIntermediateDirectories: false, attributes: nil)
//
//
//		taggedRequest.forEach { (tag, requests) in
//			let context = [
//				"models": requests,
//				"tag": tag.firstCapitalized
//			] as [String : Any]
//
//			let ext = Extension()
//			ext.registerStencilSwiftExtensions()
//			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]), extensions: [ext], templateClass: StencilSwiftTemplate.self)
////			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]))
//
//			let rendered = try! environment.renderTemplate(name: "MoyaAPI.stencil", context: context)
//
//			let path = path.appending("API/Providers/\(tag.firstCapitalized)Provider.swift")
//
////			print(rendered)
//			try? path.write(rendered, encoding: .utf8)
//		}
//
//
//
//		taggedRequest.forEach { (tag, requests) in
//			let context = [
//				"models": requests,
//				"tag": tag.firstCapitalized
//			] as [String : Any]
//
//			let ext = Extension()
//			ext.registerStencilSwiftExtensions()
//			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]), extensions: [ext], templateClass: StencilSwiftTemplate.self)
////			let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]))
//
//			let rendered = try! environment.renderTemplate(name: "MoyaServices.stencil", context: context)
//
//			let path = path.appending("API/Services/\(tag.firstCapitalized)Service.swift")
//
//			try? path.write(rendered, encoding: .utf8)
//		}
	}

	private func generateBaseTargetType(swagger: Swagger, path: Path) {
		let context = [
			"baseURL": swagger.spec.servers?.first!.url
		]

		let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]))

		do {
			let rendered = try environment.renderTemplate(name: "BaseTargetType.stencil", context: context as [String : Any])
			let path = path.appending("API/BaseTargetType.swift")

			DefaultFileWriter.write(sourceCode: rendered, path: path)
		} catch {
			DefaultReporter.report(info: "Incorrect template")
		}
	}

	private func generateBaseEndPointType(swagger: Swagger, path: Path) {
		let context = [
			"baseURL": swagger.spec.servers?.first!.url
		]

		let environment = Environment(loader: FileSystemLoader(paths: [path.appending("Templates")]))

		do {
			let rendered = try environment.renderTemplate(name: "BaseEndPointType.stencil", context: context as [String : Any])
			let path = path.appending("API/BaseEndPoint.swift")

			DefaultFileWriter.write(sourceCode: rendered, path: path)
		} catch {
			DefaultReporter.report(info: "Incorrect template")
		}
	}
}
