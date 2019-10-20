import Foundation

enum Constants: String{
    case placeholders =
        "https://jsonplaceholder.typicode.com/photos"
}

extension Constants{
    var url: URL{
        return URL(string: self.rawValue)!
    }
}

class PlaceholderViewModel{
    var placeholders = [Placeholder]()
    let session = URLSession(configuration: .default)
    var updateUI: (()->Void)?
    
    init() { }
    
    
    func bind(_ updateUI: @escaping ()->Void){
        self.updateUI = updateUI
    }
    
    func download(){
        let url = Constants.placeholders.url
        session.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode([Placeholder].self,
                                                    from: data)
                self.placeholders = result
                self.updateUI?()
            }
            catch{
                print(error)
            }
        }.resume()
    }
    
    func downloadThumbnail(_ placeholder: Placeholder, _ completion: @escaping (Data?) -> Void) {
        let urlString = URL(string: placeholder.thumbnailUrl)
        let dataTask = session.dataTask(with: urlString!) {(data, _, _) in
            completion(data)
        }
        dataTask.resume()
        
    }
    
    func downloadPicture(_ placeholder: Placeholder, _ completion: @escaping (Data?) -> Void) {
        let urlString = URL(string: placeholder.url)
        let dataTask = session.dataTask(with: urlString!) {(data, _, _) in
            completion(data)
        }
        dataTask.resume()
        
    }
    
    
    var count: Int{
        return placeholders.count
    }
    
    func title(at index: Int) -> String {
        return placeholders[index].title
    }

}

