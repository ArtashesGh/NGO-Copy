//
//  CitySelectionRouter.swift
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

@objc protocol CitySelectionRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CitySelectionDataPassing
{
  var dataStore: CitySelectionDataStore? { get set }
}

class CitySelectionRouter: NSObject, CitySelectionRoutingLogic, CitySelectionDataPassing
{
  weak var viewController: CitySelectionViewController?
  var dataStore: CitySelectionDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: CitySelectionViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: CitySelectionDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
