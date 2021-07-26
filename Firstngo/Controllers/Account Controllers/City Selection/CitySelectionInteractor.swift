//
//  CitySelectionInteractor.swift
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

protocol CitySelectionBusinessLogic
{
    func doSomething(request: CitySelection.Something.Request)
    func doGetCountry(page:String, userInput:String)
    func doGetCity(page:String, userInput:String , countryId:String)
}

protocol CitySelectionDataStore
{
    var countryId: UInt64 { get set }
    var searchCity: Bool { get set }
}

class CitySelectionInteractor: CitySelectionBusinessLogic, CitySelectionDataStore
{
    var presenter: CitySelectionPresentationLogic?
    var worker: CitySelectionWorker?
    var countryId: UInt64 = 0
    var searchCity: Bool = false
    
    // MARK: Do something
    
    func doSomething(request: CitySelection.Something.Request)
    {
        worker = CitySelectionWorker()
        let response = CitySelection.Something.Response(searchCity:searchCity, countryId: "\(countryId)")
        presenter?.presentSomething(response: response)
    }
    
    func doGetCountry(page:String, userInput:String)
    {
        worker = CitySelectionWorker()
//        presenter?.showLoader()
        _ =  worker?.doGetCountryWork(page: page,
                                      userInput: userInput,
                                      completion: { response in
                                        if (response.isSuccess) {
                                            self.presenter?.hideLoader()
                                            let countryInfo: [[String:Any]] = response.data?["object"] as! [[String:Any]]
                                            var countries:[Countries] = []
                                            
                                            do{
                                                for country in countryInfo {
                                                    let jsonData = try? JSONSerialization.data(withJSONObject:country)
                                                    let country = try  JSONDecoder().decode(Countries.self,from: jsonData!)
                                                    countries.append(country)
                                                }
                                                self.presenter?.presetntGetCountrySuccess(countries:countries)
                                            }catch let jsonErr {
                                                print(jsonErr)
                                            }
                                            
                                        } else {
                                            self.presenter?.hideLoader()
                                            self.presenter?.presentError(error: response.errorForUser)
                                        }
                                        
        })
    }
    
    func doGetCity(page:String, userInput:String , countryId:String)
       {
           worker = CitySelectionWorker()
//           presenter?.showLoader()
           _ =  worker?.doGetCityWork(page: page,
                                         userInput: userInput,
                                         countryId: countryId,
                                         completion: { response in
                                           if (response.isSuccess) {
                                               self.presenter?.hideLoader()
                                               let citysInfo: [[String:Any]] = response.data?["object"] as! [[String:Any]]
                                               var citys:[City] = []
                                               
                                               do{
                                                   for cityInfo in citysInfo {
                                                       let jsonData = try? JSONSerialization.data(withJSONObject:cityInfo)
                                                       let city = try  JSONDecoder().decode(City.self,from: jsonData!)
                                                       citys.append(city)
                                                   }
                                                   self.presenter?.presetntGetCitySuccess(citys:citys)
                                               }catch let jsonErr {
                                                   print(jsonErr)
                                               }
                                               
                                           } else {
                                               self.presenter?.hideLoader()
                                               self.presenter?.presentError(error: response.errorForUser)
                                           }
                                           
           })
       }
}

struct DispleySearchData: Codable {
    var Id: UInt64?
    var titleRu: String?
}
