//
//  NetworkingManager.swift
//  FavoritePlace
//
//  Created by 김현석 on 2023/03/19.
//

import Foundation
import Alamofire


final class NetworkingManager {
    
//    static let shared = NetworkingManager()
//
//    private init() { }
//
    typealias ParsingRestaurantListCompletion = (Result<PlaceList, NetworkError>) -> Void
    
    
    func fetchRestaurant(query: String, completionHandler: @escaping ParsingRestaurantListCompletion) {
        
        let url = RequestURL.kakao.searchRestaurantURL

        let parameter: Parameters = [
            "query" : query
        ]
                
        let header: HTTPHeaders = [
            Authorizations.kakao.authorizationKey : Authorizations.kakao.authorizationValue
        ]
        
        performRequestUrl(query: parameter, url: url, header: header) { result in
            print(result)
            completionHandler(result)
        }
        
    }
    
    func performRequestUrl(query: Parameters, url: String, header: HTTPHeaders, completionHandler: @escaping ParsingRestaurantListCompletion) {
        print(#function)
        
        AF.request(url,
                   method: .get,
                   parameters: query,
                   encoding: URLEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: PlaceList.self) { response in
            
            switch response.result {
            case .success(let restaurantList):
                completionHandler(.success(restaurantList))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
     
    }
    
}
