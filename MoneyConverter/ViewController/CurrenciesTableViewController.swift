//
//  CurrenciesTableViewController.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 4.05.21.
//

import Alamofire

class CurrenciesTableViewController: UITableViewController {
    
    var spinner = UIActivityIndicatorView(style: .large)
    var codes: [String] = []
    var conversionRates: [String : Double] = [:]
    var code: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSpinner()

        NetworkManager.shared.fetchData() { (rates) in
            guard let rates = rates?.conversionRates else { return }
            self.conversionRates = rates
            self.codes.append(contentsOf: rates.keys)
            self.codes.sort(by: <)
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    // MARK: - Table view data source
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        code = codes[indexPath.row]
    }
    

      //MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let exchangeVC = segue.destination as? ExchangeTableViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        exchangeVC.code = codes[indexPath.row]
     }
    
}

//MARK: - Private Methods
extension CurrenciesTableViewController {
    
    private func initSpinner() {
        spinner.center = tableView.center
        tableView.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
    }
}
