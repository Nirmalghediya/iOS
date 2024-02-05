//
//  SuperSaveCell.swift
//  Design
//
//  Created by Nirmal Prajapati on 13/01/24.
//

import UIKit

class SuperSaveCell: UITableViewCell {

    @IBOutlet weak var SuperCollectionView: UICollectionView!
    
   

    override func awakeFromNib() {
        super.awakeFromNib()
       
        let SuperColCell = UINib(nibName: "SuperSaveCollectionViewCell", bundle: nil)
        SuperCollectionView.register(SuperColCell, forCellWithReuseIdentifier: "SuperSaveCollectionViewCell")
        SuperCollectionView.delegate = self
        SuperCollectionView.dataSource = self
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        SuperCollectionView.layoutIfNeeded()
        SuperCollectionView.updateConstraintsIfNeeded()
    }

 

    
    

}


extension SuperSaveCell:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = SuperCollectionView.dequeueReusableCell(withReuseIdentifier: "SuperSaveCollectionViewCell", for: indexPath) as! SuperSaveCollectionViewCell
        cell.HedingView.TopCorner(view: cell.HedingView, Redius: 10)
        cell.SubView.RoundCorner(view: cell.SubView, Redius: 10)
        return cell
    }

    
}

extension SuperSaveCell: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height

        return CGSize(width: width, height: height)
    }




}

