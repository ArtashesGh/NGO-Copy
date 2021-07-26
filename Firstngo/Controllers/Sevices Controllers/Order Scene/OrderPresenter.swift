//
//  OrderPresenter.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/9/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol OrderPresentationLogic
{
    func presentSomething(isUserOrder:Bool, orderId:String)
    func presentGetProductSuccess(product: Product)
    func presentGetOrderSuccess(product: OrderElement)
    func presentPostUploadSuccess(doc : UserAndAdminDoc, displeyElements: [OrderDispleyElement])
     func presentSendOrderSuccess()
    func presentError(error: String)
    func presentPaymentSucces()
    func showLoader()
    func hideLoader()
}

class OrderPresenter: OrderPresentationLogic
{
    weak var viewController: OrderDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(isUserOrder:Bool, orderId:String)
    {
        viewController?.displaySomething(isUserOrder:isUserOrder, orderId:orderId)
    }
    
    func presentGetProductSuccess(product: Product) {
        let displeyElement1 = OrderDispleyElement(title: product.name ?? "", subTitle: "\(product.price ?? 0)" , cellType: .name)
        let displeyElement2 = OrderDispleyElement(title: product.description ?? "", cellType: .desc)
        let displeyElements: [OrderDispleyElement] = [ displeyElement1, displeyElement2]
        viewController?.displayGetSuccess(dispelyedOrderElements: displeyElements)
        
    }
    
    func presentPostUploadSuccess(doc : UserAndAdminDoc, displeyElements: [OrderDispleyElement]) {
        let timeInterval = Double(doc.creationDateLong ?? 0)
        let myNSDate = NSDate(timeIntervalSince1970: timeInterval)
        let displeyElement = OrderDispleyElement(title: doc.docName ?? "", subTitle: myNSDate.getString(), cellType: .docs, docId: doc.docId)
        var displeyElements: [OrderDispleyElement] = displeyElements
        displeyElements.append(displeyElement)
       viewController?.displayGetSuccess(dispelyedOrderElements: displeyElements)
        
    }
    
    func presentGetOrderSuccess(product: OrderElement) {
        let displeyElement1 = OrderDispleyElement(title: product.productName ?? "", subTitle: "\(product.productPrice ?? 0)" , cellType: .name)
        let displeyElement2 = OrderDispleyElement(title: product.status ?? "", cellType: .status)
        let displeyElement3 = OrderDispleyElement(title: product.productDescription ?? "", cellType: .desc)
        var displeyElements: [OrderDispleyElement] = [ displeyElement1, displeyElement2, displeyElement3]
        if product.userDocs?.count ?? 0 > 0 {
            for doc in product.userDocs ?? [] {
                let timeInterval = Double(doc.creationDateLong ?? 0)
                let myNSDate = NSDate(timeIntervalSince1970: timeInterval)
                let displeyElemen = OrderDispleyElement(title: doc.docName ?? "", subTitle: myNSDate.getString() , cellType: .docs)
                displeyElements.append(displeyElemen)
            }
        }
        if product.adminDocs?.count ?? 0 > 0 {
            for doc in product.adminDocs ?? [] {
                let timeInterval = Double(doc.creationDateLong ?? 0)
                let myNSDate = NSDate(timeIntervalSince1970: timeInterval)
                let displeyElemen = OrderDispleyElement(title: doc.docName ?? "", subTitle: myNSDate.getString() , cellType: .docs)
                displeyElements.append(displeyElemen)
            }
        }
        viewController?.displayGetSuccess(dispelyedOrderElements: displeyElements)
    }
    
    func presentSendOrderSuccess() {
        viewController?.displeySaveOrderSuccess()
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
    
    func presentPaymentSucces() {
        viewController?.displayPaymentSucces()
    }
}

struct OrderDispleyElement {
    var title : String!
    var subTitle : String!
    var cellType: OrderCellType!
    var docId : Int!
    init(title : String! = "", subTitle : String! = "", cellType: OrderCellType! = OrderCellType.none, docId : Int! = 0) {
        self.title = title
        self.subTitle = subTitle
        self.cellType = cellType
        self.docId = docId
    }
    
}


enum OrderCellType : Int8 {
    case    none,
    name,
    status,
    desc,
    docs,
    docsButton
}
