//
//  SIgnInViewController.swift
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

protocol SIgnInDisplayLogic: class
{
    func displaySuccess(viewModel: SIgnIn.Something.ViewModel)
    func displayError()
    func showLoader()
    func hideLoader()
}

class SIgnInViewController: UIViewController, SIgnInDisplayLogic
{
    var interactor: SIgnInBusinessLogic?
    var router: (NSObjectProtocol & SIgnInRoutingLogic & SIgnInDataPassing)?
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var logInView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var emailTextField: TitleTextField!
    @IBOutlet weak var passwordTextField: TitleTextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginViewTopConstraint: NSLayoutConstraint!
    
    var topConstraintHeight: CGFloat = 83.0
    var loginViewTopConstraintHeight: CGFloat = 125.0
    var topErrorConstraintHeight: CGFloat = 164.0
    var bottomConstraintHeight: CGFloat = 61.0
    
    
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
        let interactor = SIgnInInteractor()
        let presenter = SIgnInPresenter()
        let router = SIgnInRouter()
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
        logInButton.activationState(active: false)
        addTargetsTextField()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logInView.roundCorners(corners: .topRight, radius: 50)
        logInButton.roundCorners(corners:[.topLeft, .bottomLeft], radius: 20.0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doLogIn()
    {
        let request = SIgnIn.Something.Request(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        interactor?.doLogIn(request: request)
    }
    
    func displaySuccess(viewModel: SIgnIn.Something.ViewModel)
    {
        DispatchQueue.main.async {
            self.router?.routeToHomeTab()
        }
    }
    
    func displayError() {
        DispatchQueue.main.async {
            self.errorView.isHidden = false
            self.topConstraint.constant = self.topErrorConstraintHeight
        }
    }
    
    //MARK: - Hide & Show Loader
    
    func showLoader() {
        view.showLoader()
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.view.removeLoader()
        }
    }
    
    // MARK: Actions
    
    @IBAction func forgotPassword(_ sender: Any) {
        emailTextField.text = ""
        passwordTextField.text = ""
        errorView.isHidden = true
        topConstraint.constant = topConstraintHeight
        router?.routeToForgotScreen()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        doLogIn()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Target Text Field
    
    func addTargetsTextField() {
        emailTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 && textField.text?.first == " " {
            textField.text = ""
            return
        }
        guard
            let passwordStr = passwordTextField.text, !passwordStr.isEmpty,
            let emailStr = emailTextField.text, !emailStr.isEmpty
            else {
                logInButton.activationState(active: false)
                return
        }
        logInButton.activationState(active: true)
    }
    
    //    MARK: - Keyboard Show & Hide
    @objc
    func keyboardWillAppear(notification: NSNotification?) {
        
        guard let keyboardFrame = notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        let deviceModel =  UIDevice().type
        switch deviceModel {
        case  .iPhone5, .iPhone5S, .iPhone5C, .iPhoneSE:
            topConstraint.constant = 20.0
            loginViewTopConstraint.constant = 100.0
            bottomConstraint.constant = keyboardHeight + 10
        case .iPhoneX, .iPhoneXR, .iPhoneXS, .iPhoneXSMax, .iPhone11, .iPhone11Pro, .iPhone11ProMax:
            bottomConstraint.constant = keyboardHeight + 50
        default:
            bottomConstraint.constant = keyboardHeight + 10
            break
        }
        
    }
    
    @objc
    func keyboardWillDisappear(notification: NSNotification?) {
        let deviceModel =  UIDevice().type
        switch deviceModel {
        case  .iPhone5, .iPhone5S, .iPhone5C, .iPhoneSE:
            topConstraint.constant = topConstraintHeight
            loginViewTopConstraint.constant = loginViewTopConstraintHeight
        default:
            break
        }
        bottomConstraint.constant = bottomConstraintHeight
    }
}

//MARK: - Delegate

extension SIgnInViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorView.isHidden = true
        topConstraint.constant = topConstraintHeight
    }
}
