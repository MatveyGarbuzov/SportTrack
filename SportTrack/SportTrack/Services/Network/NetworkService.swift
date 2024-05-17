//
//  NetworkService.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 25.04.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Codable>(fromString: String) async -> T?
}

class NetworkService: NetworkServiceProtocol {

    func fetch<T: Codable>(fromString stringURL: String) async -> T? {
        do {
            guard let url = URL(string: stringURL) else { throw NetworkError.badUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }

            return decodedResponse
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }

        return nil
    }
}
