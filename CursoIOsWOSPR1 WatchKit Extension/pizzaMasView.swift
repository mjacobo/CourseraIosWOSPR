//
//  pizzaMasView.swift
//  CursoIOsWOSPR1
//
//  Created by Mauricio Jacobo Romero on 01/09/2016.
//  Copyright © 2016 MJ. All rights reserved.
//

import WatchKit
import Foundation


class pizzaMasView: WKInterfaceController {
    var listaOpciones : [(String, String)] = [
        ("Delgada", "Seleccione su tipo de masa:"),
        ("Mediana", "Seleccione su tipo de masa:"),
        ("Gruesa", "Seleccione su tipo de masa:")]
    
    @IBOutlet var pickerMasa: WKInterfacePicker!
    @IBOutlet var pizzaSelMasa: WKInterfaceLabel!
    
        var MyMasObj : MyOrder = MyOrder()
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        let c = context as! MyOrder
        MyMasObj=c
        
        if(c.pizzaOrderMas != PizzaMasa.NoSel){
            pizzaSelMasa.setText("\(c.pizzaOrderMas!)")
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
        
        pickerMasa.setItems(pickerItems)
        pickerMasa.setSelectedItemIndex(0)
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func selMasaOption(value: Int) {
            switch (value) {
            case 0:
                pizzaSelMasa.setText("Delgada")
                MyMasObj.pizzaOrderMas = PizzaMasa.Delgada
            case 1:
                pizzaSelMasa.setText("Mediana")
                MyMasObj.pizzaOrderMas = PizzaMasa.Mediana
            case 2:
                pizzaSelMasa.setText("Gruesa")
                MyMasObj.pizzaOrderMas = PizzaMasa.Gruesa
            default: break
            }
    }
    
}
