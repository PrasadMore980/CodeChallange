//
//  CountryInfoViewModel.swift
//  TelstraCodeExercise
//
//  Created by Prasad More on 12/02/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

protocol ServiceCallbackDelegate: class {
    func onSucessResponse(with response: CountryInfo)
    func onFailureResponse(with responseMessage: String)
}

class CountryInfoViewModel {
    weak var delegate: ServiceCallbackDelegate?
    
    var updateTitle: (() -> Void)?
    var refreshData: (() -> Void)?

    init(delegate: ServiceCallbackDelegate) {
        self.delegate = delegate
    }
    
    
    var countryInfoTitle: String?{
        didSet {
            DispatchQueue.main.async {
                self.updateTitle?()
            }
        }
    }
}

//MARK : - Web service request
extension CountryInfoViewModel {
    func fetchAPI() {
        ServiceManager().getCountryInfoData(url: Url.baseUrl) { [weak self] (result) in
            guard let self = self else { return }
            self.refreshData?()

            switch result {
            case .failure(let error):
                self.delegate?.onFailureResponse(with: error)
            case .success(let results):
                self.countryInfoTitle = results.title ?? ""
                guard let facts = results.rows else { return }
                let receivedResponse = CountryInfo(title: results.title ?? "", rows: facts)
                self.delegate?.onSucessResponse(with: receivedResponse)
            }
        }
    }
}
