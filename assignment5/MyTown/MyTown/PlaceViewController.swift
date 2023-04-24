//
//  PlaceViewController.swift
//  MyTown
//
//  Created by 宰英祺 on 2023/2/7.
//

import UIKit

class PlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: PlacesFavoritesDelegate?

    let cellReuseIdentifier = "cell"
    
    
    // https://stackoverflow.com/questions/33234180/uitableview-example-for-swift
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        dismissButton.addTarget(self, action: #selector(doneAction), for: UIControl.Event.touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.bestPlace?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        cell.textLabel?.text = DataManager.sharedInstance.favorites()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.favoritePlace(name: DataManager.sharedInstance.favorites()[indexPath.row])
    }

    @objc func doneAction(_ button: UIButton) {
        dismiss(animated: true, completion: nil)
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
