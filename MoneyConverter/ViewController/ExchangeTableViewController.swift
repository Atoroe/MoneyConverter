//
//  ExchangeTableViewController.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 5.05.21.
//

import UIKit

protocol AmountCellProtocol {
    func setNewValue(for amount: Double)
}

class ExchangeTableViewController: UITableViewController {
    
    var spinner = UIActivityIndicatorView(style: .large)
    var codes: [String] = []
    var conversionRates: [String : Double] = [:]
    var code: String!
    var amount: Double = 0
    
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
            let code = codes[indexPath.row]
            guard let rate = conversionRates[code] else { return UITableViewCell() }
            
            var content = cell.defaultContentConfiguration()
            content.text = code
            content.secondaryText = String(rate * amount )
            cell.contentConfiguration = content
            return cell
        }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "amountHeader") as! AmountHeaderView
        tableView.sectionHeaderHeight = 50
        headerView.setHeader(with: self.code)
        headerView.delegate = self

        return headerView
    }
}

//MARK: - Private methodes
extension ExchangeTableViewController {
    private func initSpinner() {
        spinner.center = tableView.center
        tableView.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
    }
}

//MARK: - AmountCellProtocol
extension ExchangeTableViewController: AmountCellProtocol {
    func setNewValue(for amount: Double) {
        self.amount = amount
        
        tableView.beginUpdates()
        
        for rowIndex in 0..<codes.count {
            let indexPath = IndexPath(row: rowIndex, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        tableView.endUpdates()
    }
}



