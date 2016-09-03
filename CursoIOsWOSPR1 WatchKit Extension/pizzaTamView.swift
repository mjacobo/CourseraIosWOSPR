//
//  pizzaTamView.swift
//  CursoIOsWOSPR1
//
//  Created by Mauricio Jacobo Romero on 01/09/2016.
//  Copyright © 2016 MJ. All rights reserved.
//

import WatchKit
import Foundation


class pizzaTamView: WKInterfaceController {
    
    var listaOpciones : [(String, String)] = [
        ("Chica", "Seleccione su tamano:"),
        ("Mediana", "Seleccione su tamano:"),
        ("Grande", "Seleccione su tamano:")]
    
    @IBOutlet var pickerTamano: WKInterfacePicker!
    @IBOutlet var pizzaSelTam: WKInterfaceLabel!
    
    var MyTamObj : MyOrder = MyOrder()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        let c = context as! MyOrder
        MyTamObj=c
        
        if(c.pizzaOrderTam != PizzaTam.NoSel){
            pizzaSelTam.setText("\(c.pizzaOrderTam!)")
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let pickerItems: [WKPickerItem] = listaOpciones.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.0
            pickerItem.caption = $0.1
            return pickerItem
        }
        
        pickerTamano.setItems(pickerItems)
        pickerTamano.setSelectedItemIndex(0)
    }

    
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func pizzaTamSelAcc(value: Int) {
        switch (value) {
        case 0:
            pizzaSelTam.setText("Chica")
            MyTamObj.pizzaOrderTam = PizzaTam.Chica
        case 1:
            pizzaSelTam.setText("Mediana")
            MyTamObj.pizzaOrderTam = PizzaTam.Mediana
        case 2:
            pizzaSelTam.setText("Grande")
            MyTamObj.pizzaOrderTam = PizzaTam.Grande
        default: break
        }
    }
}
