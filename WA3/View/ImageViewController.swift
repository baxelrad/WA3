import UIKit


class ImageViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    

  

}
