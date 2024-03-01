//
//  ProductListViewController.swift
//  MVVMProduct
//
//  Created by Nirmal Prajapati on 14/02/24.
//

import UIKit

class ProductListViewController: UIViewController {

    
    @IBOutlet weak var productTableView: UITableView!
    
    
    
    private var viewModel = ProductViewModel()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    

   

}

extension ProductListViewController {
    func configuration(){
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        initViewModel()
        observeEvent()
    }
    
    func initViewModel(){
        viewModel.fetchProduct()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            
            guard let self else { return }
            
            switch event {
            case .loading:break
                //indicator show
            case .stopLoading:break
                //indicator hide
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
            
        }
    }
}

extension ProductListViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = viewModel.product[indexPath.row]
        cell.product = product
        return cell
    }
    
    
}
