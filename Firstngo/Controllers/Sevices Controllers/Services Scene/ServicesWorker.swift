//
//  ServicesWorker.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/6/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class ServicesWorker
{
    func doGetUserServices(page: String, completion: (( _ response: ResponseData) -> Void)? ) {
        NetworkManager.requestGetUserServices(userInfo: ["page":page], completion: completion)
    }
}
