//
//  TermsAndConditionsViewController.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/16/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TermsAndConditionsDisplayLogic: class
{
    func displaySomething(viewModel: TermsAndConditions.Something.ViewModel)
}

class TermsAndConditionsViewController: UIViewController, TermsAndConditionsDisplayLogic
{
    var interactor: TermsAndConditionsBusinessLogic?
    var router: (NSObjectProtocol & TermsAndConditionsRoutingLogic & TermsAndConditionsDataPassing)?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var toPview: UIView!
    @IBOutlet weak var termsBackView: UIView!
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = TermsAndConditionsInteractor()
        let presenter = TermsAndConditionsPresenter()
        let router = TermsAndConditionsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        toPview.roundCorners(corners: .bottomLeft, radius: 50)
        termsBackView.roundCorners(corners:.bottomLeft, radius: 50.0)
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = TermsAndConditions.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: TermsAndConditions.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
