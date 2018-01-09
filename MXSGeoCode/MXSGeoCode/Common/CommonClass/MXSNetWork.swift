//
//  MXSNetWork.swift
//  MXSSwift
//
//  Created by Alfred Yang on 21/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation
import Alamofire

class MXSNetWork : NSObject {
	
	#if DEBUG
//		let RemoteRootURL = "http://altlys.com:9000/"
		let RemoteRootURL = "http://192.168.100.174:9000/"
	#else
		let RemoteRootURL = "http://altlys.com:9000/"
	#endif
	
	lazy var QueryServices : String = {
		return "al/service/search"
	}()
	
	let headers: HTTPHeaders = [
		"Content-Type": "application/json",
		"Accept": "application/json"
	]
	
	// MARK: singleton
	static let shared = MXSNetWork.init()
	
	public func requestRemote(route:String, para:Dictionary<String, Any>, completeBlock:@escaping (Dictionary<String, Any>) -> Void) {
		
		Alamofire.request( RemoteRootURL + route, method: .post, parameters: para, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
			completeBlock((response.result.value as! Dictionary<String, Any>)["result"] as! Dictionary<String, Any>)
		}
	}
	
	
	
//	condition =     {
//	};
//	token = bearerffa9837a3811b82f103b76efeafe0f1b;
	
	
}
