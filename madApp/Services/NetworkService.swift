//
//  NetworkService.swift
//  madApp
//
//  Created by Nikolay Truhin on 24/12/22.
//

import Foundation

struct Container<T: Decodable>: Decodable {
    let data: T
}

struct AuthResp: Decodable {
    let token: String
}

enum TaskStatus: String, Codable {
    case new = "New"
    case finished = "Finished"
    case progress = "In progress"
}

struct TaskStatusModel: Decodable {
    var title: TaskStatus
}

struct TaskModel: Decodable, Identifiable {
    var id: Int
    var title: String
//    var description_url: URL
//    var deadline: Date
    var status: TaskStatusModel
}

class NetworkService {
    static let shared: NetworkService = .init()
    
    var token: String? = UserDefaults.standard.string(forKey: "key") {
        didSet {
            UserDefaults.standard.set(token, forKey: "key")
        }
    }
    
    private init() {}
    
    func auth(mail: String, password: String) async -> Bool {
        let parameters = "{\n    \"email\":\"\(mail)\",\n    \"password\":\"\(password)\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: .apiUrl + "/login")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer 229|23eNQNq0nECWO0yrrg1Ltslw1CAN5hTaJZ0aKz1k", forHTTPHeaderField: "Authorization")

        request.httpMethod = "POST"
        request.httpBody = postData
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let res = try JSONDecoder().decode(Container<AuthResp>.self, from: data)
            
            token = res.data.token
            
            return true
        } catch {
            debugPrint("err")
            return false
        }
    }
    
    func getTasks() async -> [TaskModel] {
        guard let token else { return [] }
        var request = URLRequest(url: URL(string: .apiUrl + "/user/tasks")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let res = try JSONDecoder().decode(Container<[TaskModel]>.self, from: data)
            
            return res.data
        } catch {
            debugPrint("err")
            return []
        }
    }
}
