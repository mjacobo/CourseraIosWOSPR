//
//  InterfaceController.swift
//  CursoIOsWOSPR1 WatchKit Extension
//
//  Created by Mauricio Jacobo Romero on 28/08/2016.
//  Copyright © 2016 MJ. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var pizzaOrderPicker: WKInterfacePicker!
    @IBOutlet var pizzaOrdenDetail: WKInterfaceLabel!
    
    var MyFinalOrder : MyOrder = MyOrder()
    var pizzaOrderSel : Int = 0
    static let MarqueeSize: Int = 13
    var timer = NSTimer()

    var listaOpciones : [(String, String, String)] = [
        ("Tamaño", "Prepare su orden:", "No"),
        ("Masa", "Prepare su orden:", "No"),
        ("Queso", "Prepare su orden:", "No"),
        ("Ingredientes", "Prepare su orden:", "No"),
        ("Rebanadas", "Prepare su orden:", "No"),
        ("Entrega", "Prepare su orden:", "No" ),
        ("Confirmar", "Prepare su orden:", "No") ]
   
    let MyMarquee = Marquee(lenght: MarqueeSize)
    
    
    @IBAction func pizzaOrderSelItmAct(value: Int) {
        pizzaOrderSel = value
        print("List Picker: \(listaOpciones[pizzaOrderSel]) selected")
    }
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    
        if(MyFinalOrder.pizzaOrderTam != PizzaTam.NoSel) {
            listaOpciones[0] = ("Tamaño", "Prepare su orden:", "Yes")
        } else {
            listaOpciones[0] = ("Tamaño", "Prepare su orden:", "No")
        }
        
        if(MyFinalOrder.pizzaOrderMas != PizzaMasa.NoSel) {
            listaOpciones[1] = ("Masa", "Prepare su orden:", "Yes")
        } else {
            listaOpciones[1] = ("Masa", "Prepare su orden:", "No")
        }

        if(MyFinalOrder.pizzaOrderQue != PizzaQueso.NoSel) {
            listaOpciones[2] = ("Queso", "Prepare su orden:", "Yes")
        } else {
            listaOpciones[2] = ("Queso", "Prepare su orden:", "No")
        }
        
        if(MyFinalOrder.pizzaOrderIng!.misIngredientes["NoSel"] != true) {
            listaOpciones[3] = ("Ingredientes", "Prepare su orden:", "Yes")
        } else {
            listaOpciones[3] = ("Ingredientes", "Prepare su orden:", "No")
        }
        
        if(MyFinalOrder.pizzaOrderReb != PizzaOrderRebanada.NoSel) {
            listaOpciones[4] = ("Rebanadas", "Prepare su orden:", "Yes")
        } else {
            listaOpciones[4] = ("Rebanadas", "Prepare su orden:", "No")
        }
        
        if(MyFinalOrder.pizzaOrderEnt != PizzaOrderEntrega.NoSel) {
            listaOpciones[5] = ("Entrega", "Prepare su orden:", "Yes")
        } else {
            listaOpciones[5] = ("Entrega", "Prepare su orden:", "No")
        }
        
        let pickerItems: [WKPickerItem] = listaOpciones.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.0
            pickerItem.caption = $0.1
            pickerItem.accessoryImage =  WKImage(imageName: $0.2)
            return pickerItem
        }
        
        pizzaOrderPicker.setItems(pickerItems)
        pizzaOrderPicker.setSelectedItemIndex(pizzaOrderSel)
        MyMarquee.cleanMyMarquee()
        pizzaOrdenDetail.setText("")
        MyMarquee.setMyMessage(MyFinalOrder.printMyOrder())
        scheduledTimerWithTimeInterval()
        

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function **Countdown** with the interval of 1 seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(InterfaceController.updateCounting), userInfo: nil, repeats: true)
    }
    
    func updateCounting(){
       pizzaOrdenDetail.setText(MyMarquee.runMyMarquee())
    }
    
    func confirmarOrden () {
    if( MyFinalOrder.pizzaOrderTam != PizzaTam.NoSel           &&
        MyFinalOrder.pizzaOrderMas != PizzaMasa.NoSel          &&
        MyFinalOrder.pizzaOrderQue != PizzaQueso.NoSel         &&
        MyFinalOrder.pizzaOrderIng!.misIngredientes["NoSel"] != true  &&
        MyFinalOrder.pizzaOrderReb != PizzaOrderRebanada.NoSel &&
        MyFinalOrder.pizzaOrderEnt != PizzaOrderEntrega.NoSel)
    {
        let action1 = WKAlertAction(title: "Si", style: WKAlertActionStyle.Default, handler: { self.resetValues()})
        
        let action2 = WKAlertAction(title: "Cancelar", style: WKAlertActionStyle.Default, handler: { () -> Void in })
        
        presentAlertControllerWithTitle("Confirmar orden",message:"¿Desea confirmar la orden?",preferredStyle: WKAlertControllerStyle.SideBySideButtonsAlert, actions: [action1, action2])
        
    } else {
        let action1 = WKAlertAction(title: "OK", style: WKAlertActionStyle.Default, handler: { () -> Void in })
        presentAlertControllerWithTitle("Orden incompleta",message:"Su orden no está completa. Las Xs le indican que le falta ordenar.",preferredStyle: WKAlertControllerStyle.Alert, actions: [action1])
        }
    }
    
    func resetValues() {
        
        let action1 = WKAlertAction(title: "OK", style: WKAlertActionStyle.Default, handler: { () -> Void in })
        
        presentAlertControllerWithTitle("Cocinando",message:"Su orden se está cocinando. \n Presione OK para hacer otro pedido.",preferredStyle: WKAlertControllerStyle.Alert, actions: [action1])
        
        MyFinalOrder.pizzaOrderTam = PizzaTam.NoSel
        MyFinalOrder.pizzaOrderMas = PizzaMasa.NoSel
        MyFinalOrder.pizzaOrderQue = PizzaQueso.NoSel
        for i in (MyFinalOrder.pizzaOrderIng?.misIngredientes)! {
              MyFinalOrder.pizzaOrderIng?.misIngredientes[i.0] = false
        }
        MyFinalOrder.pizzaOrderIng?.misIngredientes["NoSel"] = true
        MyFinalOrder.pizzaOrderReb = PizzaOrderRebanada.NoSel
        MyFinalOrder.pizzaOrderEnt = PizzaOrderEntrega.NoSel
        pizzaOrderSel = 0
    }
    
    @IBAction func pizzaOrderAction() {
        switch (pizzaOrderSel) {
        case 0  :
            pushControllerWithName("PizzaTamano", context: MyFinalOrder)
        case 1  :
            pushControllerWithName("PizzaMasa", context: MyFinalOrder)
        case 2  :
            pushControllerWithName("PizzaQueso", context: MyFinalOrder)
        case 3  :
            pushControllerWithName("PizzaIngredientes", context: MyFinalOrder)            
        case 4  :
            pushControllerWithName("PizzaRebanadas", context: MyFinalOrder)
        case 5  :
            pushControllerWithName("PizzaEntrega", context: MyFinalOrder)
        case 6  :
            confirmarOrden()
        default : print("No selection");
        }
    }
    
    
}
