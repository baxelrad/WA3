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
    }
}

extension PlaceholderViewController: UITableViewDataSource, UITableViewDelegate {
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
        
        vm.downloadPicture(thisPH){ (imData) in
            if let imData = imData{
                let image = UIImage(data: imData)
                DispatchQueue.main.async{
                    cell.thumbnailView.image = image
                }
                cell.loadingView.stopAnimating()
            }
        }
        
        
        

        
        return cell
    }
}
