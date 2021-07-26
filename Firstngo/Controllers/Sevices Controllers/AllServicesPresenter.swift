//
//  AllServicesPresenter.swift
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

protocol AllServicesPresentationLogic
{
    func presentSuccess(allServic:[AllServiceElement])
    func presentGetProfileSuccess(userInfo: User)
    func presentError(error: String)
    func showLoader()
    func hideLoader()
}

class AllServicesPresenter: AllServicesPresentationLogic
{
    weak var viewController: AllServicesDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: AllServices.Something.Response)
    {
        let viewModel = AllServices.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentSuccess(allServic:[AllServiceElement]) {
        viewController?.displayGetSuccess(orders: allServic)
    }
    
    func presentGetProfileSuccess(userInfo: User) {
           viewController?.displeyGetUser(userInfo: userInfo)
       }
    
    func presentError(error: String) {
        viewController?.displayError()
    }
    
    func showLoader() {
        viewController?.showLoader()
    }
    func hideLoader() {
        viewController?.hideLoader()
    }
}
