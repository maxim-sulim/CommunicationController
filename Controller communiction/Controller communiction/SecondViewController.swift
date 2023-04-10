//
//  SecondViewController.swift
//  Controller communiction
//
//  Created by Максим Сулим on 27.03.2023.
//

import UIKit


class SecondViewController: UIViewController, UpdatingDataController {
    
    @IBOutlet var dataTextField: UITextField!
    var updatingData: String? = ""
    var handleUpdatedDataProtocol: DataUpdateProtocol?
    var complecionHandler: ((String?) -> Void)?
    
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach{
            viewController in (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        }
    }
    
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        handleUpdatedDataProtocol?.onDataUpdate(data: updatedData)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveDataWithClouser(_ sender: UIButton) {
        updatingData = dataTextField.text ?? ""
        complecionHandler?(updatingData)
        navigationController?.popViewController(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case "toFirstScrean": prepareFirstScrean(segue)
        default: break
        }
    }
    
    private func prepareFirstScrean (_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? ViewController else { return }
        destinationController.updatedData = dataTextField.text
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    private func updateTextFieldData(withText text: String?) {
        dataTextField.text = text
    }
}
