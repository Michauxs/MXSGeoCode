//
//  MXSLocationMng.swift
//  MXSGeoCode
//
//  Created by Alfred Yang on 9/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit
import CoreLocation

class MXSLocationMng: NSObject {

//	let shared = MXSLocationMng()
	static let shared = MXSLocationMng.init()
	
	lazy var geoCoder: CLGeocoder = {
		return CLGeocoder()
	}()
	
	public func getLocation(_ addr:String, completeBlock:@escaping (Any) -> Void) {
		self.geoCoder.geocodeAddressString(addr) { (pls: [CLPlacemark]?, error: Error?) in
			if error == nil {
				guard let plsResult = pls else {
					completeBlock(MXSNothing.shared)
					return
				}
				let firstPL = plsResult.first
				completeBlock(firstPL!)
			}
		}
	}
}
