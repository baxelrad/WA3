import UIKit


class PlaceholderViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            let nib = UINib(nibName: "PlaceholderTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PlaceholderTableViewCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 200
        }
    }

    var vm = PlaceholderViewModel()
    var imageName: String = ""
    var colorArray = [UIColor]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let updateUI: ()->Void = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        vm.bind(updateUI)
        vm.download()
        //print(vm.placeholders)
        
        randomColor()
    }
    
    func randomColor(){
        var colorArr = [UIColor]()
        for _ in 0..<101{
            colorArr.append(UIColor(displayP3Red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), green: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), alpha: 1))
        }
        colorArray = colorArr
    }
    
}

extension PlaceholderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceholderTableViewCell", for: indexPath) as! PlaceholderTableViewCell
        
        cell.titleLabel.text = vm.placeholders[indexPath.row].title
        cell.idLabel.text = "\(vm.placeholders[indexPath.row].id)"
        cell.albumIdLabel.text = "\(vm.placeholders[indexPath.row].albumId)"
        let thisPH = vm.placeholders[indexPath.row]

        cell.loadingView.startAnimating()
        

        cell.backgroundColor = colorArray[thisPH.albumId]
        
        vm.downloadThumbnail(thisPH){ (imData) in
            if let imData = imData{
                let image = UIImage(data: imData)
                DispatchQueue.main.async{
                    cell.thumbnailView.image = image
                    cell.loadingView.stopAnimating()

                }
            }
        }
        imageName = vm.placeholders[indexPath.row].url
        return cell
    }
}

extension PlaceholderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        let thisPH = vm.placeholders[indexPath.row]
        vm.downloadPicture(thisPH){ (imData) in
            if let imData = imData{
                let image = UIImage(data: imData)
                vc.image = image
            }
        }
        show(vc, sender: nil)
    }
}
