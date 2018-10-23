//
//  HttpHelper.swift
//  appstore-search
//
//  Created by Nandika on 10/2/18.
//  Copyright © 2018 SLIIT. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HttpHelper {
    
    let url = "https://itunes.apple.com/search"
    
    private static var sharedInstance: HttpHelper = {
        
        let helper = HttpHelper()
        
        return helper
    }()
    
    // Initialization
    private init() {
        
    }
    
    class func shared() -> HttpHelper {
        return sharedInstance
    }
    
    // Supports GET requests
    func getRequest(seachValue : String, completion: @escaping (Bool, [Software]) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        guard let getParameters: [String: Any] = getParameters(from: seachValue) else {
            print("Can not serialize the job")
            return
        }
        
        Alamofire.request(url,
                          method: .get,
                          parameters: getParameters,
                          headers: headers)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    let data = JSON(response.result.value!)
                    
                    var softwares = [Software]()
                    
                    for result in data["results"].arrayValue {
                        let software = Software()
                        
                        software.name = result["trackName"].stringValue
                        software.companyName = result["sellerName"].stringValue
                        software.type = "App"// result["wrapperType"].stringValue
                        software.genre = result["genres"][0].stringValue
                        software.formattedPrice = result["formattedPrice"].stringValue
                        software.appIconURL = result["artworkUrl60"].stringValue
//                        let imageData = try! Data(contentsOf : URL(string: software.appIconURL)!)
//                        software.appIcon = imageData
                        
                        softwares.append(software)
                    }
                
                completion(true, softwares)
                case .failure(let error):
                    
                    print(error)
                }
        }
    }
    
    func getParameters(from searchValue: String) -> [String: Any]? {
        let parameters: [String: Any] = [
            "term" : searchValue,
            "limit" : 200,
            "entity" : "software"
        ]
        
        return parameters
    }
}


