//
//  SIgnInPresenter.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/21/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SIgnInPresentationLogic
{
    func presentSuccess(response: SIgnIn.Something.Response)
    func presentError(error: String)
    func showLoader()
    func hideLoader()
}

class SIgnInPresenter: SIgnInPresentationLogic
{
    weak var viewController: SIgnInDisplayLogic?
    
    // MARK: Do something
    
    func presentSuccess(response: SIgnIn.Something.Response)
    {
        let viewModel = SIgnIn.Something.ViewModel()
        viewController?.displaySuccess(viewModel: viewModel)
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
