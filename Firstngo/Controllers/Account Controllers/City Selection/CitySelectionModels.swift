//
//  CitySelectionModels.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/1/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum CitySelection
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
    }
    struct Response
    {
        var searchCity: Bool
        var countryId: String
    }
    struct ViewModel
    {
        var searchCity: Bool = false
        var countryId: String = ""
    }
  }
}
