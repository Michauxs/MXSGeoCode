//
//  MXSHomeVC.swift
//  MXSGeoCode
//
//  Created by Alfred Yang on 9/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit
import CoreLocation
import SnapKit

class MXSHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.white
		
		let startBtn = UIButton.init(text: "Start", fontSize: 14, textColor: .white, background: UIColor.theme)
		view.addSubview(startBtn)
		//		startBtn.frame = CGRect.init(x: 50, y: 150, width: 205, height: 50)
		startBtn.addTarget(self, action: #selector(startBtnClick), for: .touchUpInside)
		startBtn.snp.makeConstraints { (make) in
			make.center.equalTo(view);
			make.size.equalTo(CGSize.init(width: 80, height: 40))
		}
		
		let Single = UIButton.init(text: "Single", fontSize: 14, textColor: .white, background: UIColor.theme)
		view.addSubview(Single)
		Single.addTarget(self, action: #selector(singleBtnClick), for: .touchUpInside)
		Single.snp.makeConstraints { (make) in
			make.center.equalTo(view).offset(80);
			make.size.equalTo(CGSize.init(width: 80, height: 40))
		}
		
		let filter = UIButton.init(text: "filter", fontSize: 14, textColor: .white, background: UIColor.theme)
		view.addSubview(filter)
		filter.addTarget(self, action: #selector(filterBtnClick), for: .touchUpInside)
		filter.snp.makeConstraints { (make) in
			make.center.equalTo(view).offset(-80);
			make.size.equalTo(CGSize.init(width: 80, height: 40))
		}
    }

	
	//MARK:actions
	@objc func filterBtnClick () {
		//		let home = NSHomeDirectory() as NSString;
		//		let filePath = docPath.stringByAppendingPathComponent("data.plist");
		
		let unpath = "/Users/alfredyang/Desktop/DongDa/DongDaData/unlocation.plist"
		let dataSource = NSArray(contentsOfFile: unpath);
		
		let list = NSMutableArray.init()
		let list_ungeo = NSMutableArray.init()
		
		
		let mySemaphore = DispatchSemaphore(value: 0)
		DispatchQueue(label: "一条线程").async {
			//
			for var addr in dataSource! {
				let index = dataSource!.index(of: addr)
				print("-------------" + "\(index)" + "-------------")
				if index%30 == 0 {
					sleep(10)
				}
				print(addr as Any)
				
				var location = Dictionary<String, Any>.init()
				location["addr"] = addr
				
				MXSLocationMng.shared.getLocation(addr as! String, completeBlock: { (place) in
					if place is MXSNothing {
						print("no")
						list_ungeo.add(addr as Any)
					} else if place is NSNumber {
						list_ungeo.add(addr as Any)
					} else {
						print((place as! CLPlacemark).location?.coordinate.latitude as Any)
						location["latitude"] = NSNumber.init(value: ((place as! CLPlacemark).location?.coordinate.latitude)!)
						print((place as! CLPlacemark).location?.coordinate.longitude as Any)
						location["longitude"] = NSNumber.init(value: ((place as! CLPlacemark).location?.coordinate.longitude)!)
						list.add(location)
						
						mySemaphore.signal()
					}
				})
				
				let _ = mySemaphore.wait(timeout: DispatchTime.now() + 5.0)
			}
			
			DispatchQueue.main.async {
				//					let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
				let path = "/Users/alfredyang/Desktop/DongDa/DongDaData/location.plist"
				let geoData = NSArray(contentsOfFile: path);
				
				list.addObjects(from: geoData! as! [Any])
				list.write(toFile: path, atomically: true)
				
				let unpath = "/Users/alfredyang/Desktop/DongDa/DongDaData/unlocation.plist"
				list_ungeo.write(toFile: unpath, atomically: true)
				
				print(list_ungeo)
			}
			
		}
		
	}
	
	@objc func singleBtnClick () {
		
		let path = "/Users/alfredyang/Desktop/DongDa/DongDaData/location.plist"
		let geoData = NSArray(contentsOfFile: path);
		
		let unpath = "/Users/alfredyang/Desktop/DongDa/DongDaData/unlocation.plist"
		let ungeoData = NSArray(contentsOfFile: unpath);
		
		print(ungeoData!)
		print(geoData!)
//		MXSLocationMng.shared.getLocation("大兴区天宫院街道龙湖时代天街2层2F-53", completeBlock: { (place) in
//			if place is MXSNothing {
//				print("nil")
//			} else if place is NSNumber {
//				print("no")
//			}  else {
//				print((place as! CLPlacemark).location?.coordinate.latitude as Any)
//				print((place as! CLPlacemark).location?.coordinate.longitude as Any)
//			}
//		})
	}
	
	@objc func startBtnClick () {
		
//		let para = ["token":"bearerffa9837a3811b82f103b76efeafe0f1b", "condition":[], "take":NSNumber.init(value: 1000) ] as [String : Any]
//		MXSNetWork.shared.requestRemote(route: MXSNetWork.shared.QueryServices, para: para) { (result) in
//			let services = result["services"] as! NSArray
//			let list = NSMutableArray.init()
//
//			for var dic in services {
//				let addr = (dic as! NSDictionary)["address"] as! NSString
//				print("-------------")
//				print(services.index(of: dic))
//				print(addr as Any)
//
//				var location = Dictionary<String, Any>.init()
//				location["addr"] = addr
//
//				var is_copy = false
//				var cut_count = 0
//				repeat {
//					let sub_addr = addr.substring(to: addr.length - cut_count)
//					MXSLocationMng.shared.getLocation(sub_addr , completeBlock: { (place) in
//						if place is MXSNothing {
//							print("nil")
//						} else if place is NSNumber {
//							print("no -> cut:"+(addr as String))
//						} else {
//							print((place as! CLPlacemark).location?.coordinate.latitude as Any)
//							location["latitude"] = NSNumber.init(value: ((place as! CLPlacemark).location?.coordinate.latitude)!)
//							print((place as! CLPlacemark).location?.coordinate.longitude as Any)
//							location["longitude"] = NSNumber.init(value: ((place as! CLPlacemark).location?.coordinate.longitude)!)
//							list.add(location)
//							is_copy = true
//						}
//					})
//
//					is_copy = cut_count == addr.length
//					cut_count += 1
//				} while is_copy == false
//
//			}
//
//			DispatchQueue.main.async {
//				let path = "/Users/alfredyang/Desktop/DongDa/DongDaData/location.plist"
//				list.write(toFile: path, atomically: true)
//			}
//
//		}
		
		let para = ["token":"bearerc6f88361807aa0d1de5215b5ee29b9fd", "condition":["user_id":"c6f88361807aa0d1de5215b5ee29b9fd"], "take":NSNumber.init(value: 1000) ] as [String : Any]
		MXSNetWork.shared.requestRemote(route: MXSNetWork.shared.QueryServices, para: para) { (result) in

			let services = result["services"] as! NSArray
//			var list = Array<Dictionary<String,Any>>.init()
			
			let list_addr = NSMutableArray.init()
			for var dic in services {
				let address = (dic as! Dictionary<String, Any>)["address"]
				
				if !list_addr.contains(address as Any) {
					list_addr.add(address as Any)
				}
			}
			
			let list = NSMutableArray.init()
			let list_ungeo = NSMutableArray.init()
			
			let mySemaphore = DispatchSemaphore(value: 0)
			DispatchQueue(label: "一条线程").async {
				//
				for var addr in list_addr {
					let index = list_addr.index(of: addr)
					print("-------------" + "\(index)" + "-------------")
					if index%30 == 0 {
						sleep(5)
					}
					print(addr as Any)

					var location = Dictionary<String, Any>.init()
					location["addr"] = addr

					MXSLocationMng.shared.getLocation(addr as! String, completeBlock: { (place) in
						if place is MXSNothing {
							print("no")
							list_ungeo.add(addr as Any)
						} else if place is NSNumber {
							list_ungeo.add(addr as Any)
						} else {
							print((place as! CLPlacemark).location?.coordinate.latitude as Any)
							location["latitude"] = NSNumber.init(value: ((place as! CLPlacemark).location?.coordinate.latitude)!)
							print((place as! CLPlacemark).location?.coordinate.longitude as Any)
							location["longitude"] = NSNumber.init(value: ((place as! CLPlacemark).location?.coordinate.longitude)!)
							list.add(location)

							mySemaphore.signal()
						}
					})

					let _ = mySemaphore.wait(timeout: DispatchTime.now() + 2.0)
				}

				DispatchQueue.main.async {
//					let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
					let path = "/Users/alfredyang/Desktop/DongDa/DongDaData/location.plist"
					list.write(toFile: path, atomically: true)
					
					let unpath = "/Users/alfredyang/Desktop/DongDa/DongDaData/unlocation.plist"
					list_ungeo.write(toFile: unpath, atomically: true)
					print(list_ungeo)
				}

			}

		}
	}
	
    /*
    // MARK: - Navigation
*/
}
