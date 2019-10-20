import UIKit


class ImageViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var image: UIImage?
    
    lazy var swipeGesture: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self,
                                             action: #selector(swipeAction))
        swipe.direction = .down
        return swipe
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        imageView.addGestureRecognizer(swipeGesture)
        imageView.isUserInteractionEnabled = true

    }
    
    @objc func swipeAction() {
        dismiss(animated: true, completion: nil)
    }
  

}
