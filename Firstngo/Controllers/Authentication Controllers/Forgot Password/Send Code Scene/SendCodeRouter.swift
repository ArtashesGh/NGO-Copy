//
//  SendCodeRouter.swift
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

@objc protocol SendCodeRoutingLogic
{
    func routeToNewPassword()
}

protocol SendCodeDataPassing
{
    var dataStore: SendCodeDataStore? { get set }
}

class SendCodeRouter: NSObject, SendCodeRoutingLogic, SendCodeDataPassing
{
    weak var viewController: SendCodeViewController?
    var dataStore: SendCodeDataStore?
    
    // MARK: Routing
    
    func routeToNewPassword()
    {
        let destinationVC = Constants.Storyboards.authenticationStoryboard.instantiateViewController(withIdentifier: "NewPasswordViewController") as! NewPasswordViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToNewPassword(source: dataStore!, destination: &destinationDS)
        navigateToNewPassword(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToNewPassword(source: SendCodeViewController, destination: NewPasswordViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToNewPassword(source: SendCodeDataStore, destination: inout NewPasswordDataStore)
    {
        destination.email = source.email
        destination.code = source.code
    }
}
