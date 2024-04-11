

import UIKit

class ViewVC: UIViewController {

    
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    
    var drawingList: [ImageModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ImageCollectionView.register(UINib(nibName: "ImageCVCell", bundle: nil), forCellWithReuseIdentifier: "ImageCVCell")
        
        
        ImageCollectionView.delegate = self
        ImageCollectionView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("is hidden \(UserDefaults.standard.object(forKey: "savedDrawings") == nil)")
        
        ImageCollectionView.isHidden = UserDefaults.standard.object(forKey: "savedDrawings") == nil
        
        if UserDefaults.standard.object(forKey: "savedDrawings") != nil {
            let decoded  = UserDefaults.standard.data(forKey: "savedDrawings")
            do {
                let list = try JSONDecoder().decode([ImageModel].self, from: decoded!)
                drawingList = list
                ImageCollectionView.reloadData()
            } catch let error {
                let alert = UIAlertController(title: "Error getting drawings", message: "error.localizedDescription", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func btn_Back(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
  

}

extension ViewVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if drawingList?.count != 0 {
            return drawingList?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCVCell", for: indexPath) as! ImageCVCell
        cell.Save_Image.image = UIImage(data: drawingList![indexPath.row].data)
        cell.BG_View.View4x4(view: cell.BG_View, Redius: 10)
        cell.Save_Image.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditVC") as! EditVC
        vc.drawingId = drawingList![indexPath.row].id
        vc.imageGot = UIImage(data: drawingList![indexPath.row].data)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: CollectionViewDelegateFlowLayout
extension ViewVC:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
          let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.2
        return CGSize(width: size, height: size * 1.4)
      }

}
