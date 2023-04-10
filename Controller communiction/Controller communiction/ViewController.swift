//
//  ViewController.swift
//  Controller communiction
//
//  Created by Максим Сулим on 27.03.2023.
//

import UIKit

protocol UpdatingDataController {
    var updatingData: String? { get set }
}


class ViewController: UIViewController, DataUpdateProtocol {
    func onDataUpdate(data: String) {
        updatedData = data
        updateLable(data)
    }
    
    
    var updatedData: String? = "text text"
    
    
    @IBOutlet weak var dataLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLable(updatedData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEditScrean":
            prepareEditScrean(segue)
        default: break
        }
    }
    
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editScrean = storyboard.instantiateViewController(withIdentifier:
         "SecondViewConrtoller") as! UpdatingDataController
        
        editScrean.updatingData = dataLable.text ?? ""
        
        self.navigationController?.pushViewController(editScrean as! UIViewController, animated: true)
        
    }
    
    
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScrean = storyboard.instantiateViewController(withIdentifier: "SecondViewConrtoller") as! SecondViewController
        
        editScrean.updatingData = dataLable.text ?? ""
        
        editScrean.handleUpdatedDataProtocol = self
        
        self.navigationController?.pushViewController(editScrean, animated: true)
    }
    
    
    @IBAction func editDataWithClosure(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScrean = storyboard.instantiateViewController(withIdentifier: "SecondViewConrtoller") as! SecondViewController
        
        editScrean.updatingData = dataLable.text ?? ""
        
        editScrean.complecionHandler = {
            [unowned self] updatedValue in
            updatedData = updatedValue
            updateLable(updatedValue)
        }
        self.navigationController?.pushViewController(editScrean, animated: true)
    }
    
    @IBAction func unwindToFirstScene( _ segue: UIStoryboardSegue) { }
    
    private func updateLable(_ text: String?) {
        dataLable.text = text
    }

    
    private func prepareEditScrean( _ segue: UIStoryboardSegue ) {
        guard segue.destination is SecondViewController
        else { return }
    }
    
}

