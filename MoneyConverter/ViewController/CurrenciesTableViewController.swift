//
//  CurrenciesTableViewController.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 4.05.21.
//

import Alamofire

class CurrenciesTableViewController: UITableViewController {

    let url = "https://v6.exchangerate-api.com/v6/667fa215140eb6a05a16c31a/latest/RUB"
    
    var codes: [String] = []
    var conversionRates: [String : Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        codes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let code = codes[indexPath.row]
        guard let rate = conversionRates[code] else { return UITableViewCell() }
        
        var content = cell.defaultContentConfiguration()
        content.text = code
        content.secondaryText = String(rate)
        cell.contentConfiguration = content

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

    //MARK: - Private Methods
extension CurrenciesTableViewController {
    private func fetchData() {
        AF.request(url)
            .validate()
            .responseDecodable(of: Rate.self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let rates = value.conversionRates else { return }
                    self.conversionRates = rates
                    self.codes.append(contentsOf: rates.keys)
                    self.codes.sort(by: <)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
            }
    }
}
