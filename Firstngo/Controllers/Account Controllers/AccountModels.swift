//
//  AccountModels.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/24/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Account
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
    }
    struct Response
    {
        var userInfo:User
    }
    struct ViewModel
    {
        var displeyElemnt:User
    }
  }
}
