//
//  ProductViewModel.swift
//  MVVMProduct
//
//  Created by Nirmal Prajapati on 14/02/24.
//

import Foundation

final class ProductViewModel {
    
    var product: [Product] = []
    var eventHandler: ((_ event:Event) -> Void)?
    
    func fetchProduct()
    {
        self.eventHandler?(.loading)
        APIManager.shared.featchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let product):
                self.product = product
                self.eventHandler?(.dataLoaded)
                print(product)
            case .failure(let error):
                self.eventHandler?(.error(error))
                print(error)
            }
        }

    }
    
    
}


extension ProductViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
