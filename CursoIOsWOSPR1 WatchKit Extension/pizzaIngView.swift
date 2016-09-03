//
//  pizzaIngView.swift
//  CursoIOsWOSPR1
//
//  Created by Mauricio Jacobo Romero on 02/09/2016.
//  Copyright © 2016 MJ. All rights reserved.
//

import WatchKit
import Foundation


class pizzaIngView: WKInterfaceController {
    var listaOpciones : [(String, String, String)] = [
        ("Aceituna", "Ingredientes:", "No"),
        ("Anchoa", "Ingredientes:", "No"),
        ("Cebolla", "Ingredientes:", "No"),
        ("Jamon", "Ingredientes:", "No"),
        ("Pavo", "Ingredientes:", "No"),
        ("Pepperoni", "Ingredientes:", "No"),
        ("Pimiento", "Ingredientes:", "No"),
        ("Piña", "Ingredientes:", "No"),
        ("Salchicha", "Ingredientes:", "No")]
    
    @IBOutlet var pickerIngredientes: WKInterfacePicker!
    @IBOutlet var pizzaSelIngredients: WKInterfaceLabel!
    
    var pizzaIngredSel : Int = 0
    var MyIngObj : MyOrder = MyOrder()
    var timer = NSTimer()
    static let MarqueeSize: Int = 13
    let MyMarquee = Marquee(lenght: MarqueeSize)

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        let c = context as! MyOrder
        MyIngObj=c
        
        if(c.pizzaOrderIng?.misIngredientes["NoSel"] != true){
            pizzaSelIngredients.setText("")
        }
        
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function **Countdown** with the interval of 1 seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(InterfaceController.updateCounting), userInfo: nil, repeats: true)
    }
    
    func updateCounting(){
        pizzaSelIngredients.setText(MyMarquee.runMyMarquee())
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if(MyIngObj.pizzaOrderIng?.misIngredientes["Aceituna"] == true) {
            listaOpciones[0] = ("Aceituna", "Ingredientes:", "Yes")
        }
        
        if(MyIngObj.pizzaOrderIng?.misIngredientes["Anchoa"] == true) {
            listaOpciones[1] = ("Anchoa", "Ingredientes:", "Yes")
        }
        
        if(MyIngObj.pizzaOrderIng?.misIngredientes["Cebolla"] == true) {
            listaOpciones[2] = ("Cebolla", "Ingredientes:", "Yes")
        }
        
        if(MyIngObj.pizzaOrderIng?.misIngredientes["Jamon"] == true) {
            listaOpciones[3] = ("Jamon", "Ingredientes:", "Yes")
        }
        
        if(MyIngObj.pizzaOrderIng?.misIngredientes["Pavo"] == true) {
            listaOpciones[4] = ("Pavo", "Ingredientes:", "Yes")
        }
        
        if(MyIngObj.pizzaOrderIng?.misIngredientes["Pepperoni"] == true) {
            listaOpciones[5] = ("Pepperoni", "Ingredientes:", "Yes")
        }
        
        if(MyIngObj.pizzaOrderIng?.misIngredientes["Pimiento"] == true) {
            listaOpciones[6] = ("Pimiento", "Ingredientes:", "Yes")
        }
        
        if(MyIngObj.pizzaOrderIng?.misIngredientes["Piña"] == true) {
            listaOpciones[7] = ("Piña", "Ingredientes:", "Yes")
        }
        
        if(MyIngObj.pizzaOrderIng?.misIngredientes["Salchicha"] == true) {
            listaOpciones[8] = ("Salchicha", "Ingredientes:", "Yes")
        }

        let pickerItems: [WKPickerItem] = listaOpciones.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.0
            pickerItem.caption = $0.1
            pickerItem.accessoryImage =  WKImage(imageName: $0.2)
            return pickerItem
        }
        
        pickerIngredientes.setItems(pickerItems)
        pickerIngredientes.setSelectedItemIndex(pizzaIngredSel)
        
        MyMarquee.cleanMyMarquee()
        pizzaSelIngredients.setText("")
        MyMarquee.setMyMessage(MyIngObj.pizzaOrderIng!.printMyIngredients() + "    ##    ")
        scheduledTimerWithTimeInterval()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateOrderIngredient (Ingred: String){
        if(MyIngObj.pizzaOrderIng?.AddMyIngredient(Ingred, Include: true) == true){
            changeMyIconList(pizzaIngredSel, elem: Ingred, image: (MyIngObj.pizzaOrderIng?.misIngredientes[Ingred]==true) ? "Yes": "No")
            MyMarquee.cleanMyMarquee()
            pizzaSelIngredients.setText("")
            MyMarquee.setMyMessage(MyIngObj.pizzaOrderIng!.printMyIngredients() + "    ##    ")
        } else {
            let action1 = WKAlertAction(title: "OK", style: WKAlertActionStyle.Default, handler: { () -> Void in })
            presentAlertControllerWithTitle("Ingredientes",message:"Hasta 5. \n Si desea agregar otro, deseleccione uno de los que ya eligió.",preferredStyle: WKAlertControllerStyle.Alert, actions: [action1])
        }
    }
    
    func changeMyIconList(value: Int, elem: String, image: String){
        listaOpciones[value] = (elem, "Ingredientes:", image)
        let pickerItems: [WKPickerItem] = listaOpciones.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.0
            pickerItem.caption = $0.1
            pickerItem.accessoryImage =  WKImage(imageName: $0.2)
            return pickerItem
        }
        
        pickerIngredientes.setItems(pickerItems)
        pickerIngredientes.setSelectedItemIndex(value)
    }
    
    
    @IBAction func pizzaPickIngred(value: Int) {
        pizzaIngredSel = value
        print("\(listaOpciones[pizzaIngredSel])")
    }

    
    @IBAction func assignPizzaIngred() {
        switch (pizzaIngredSel) {
        case 0  :
            updateOrderIngredient ("Aceituna")
        case 1  :
            updateOrderIngredient ("Anchoa")
        case 2  :
            updateOrderIngredient ("Cebolla")
        case 3  :
            updateOrderIngredient ("Jamon")
        case 4  :
            updateOrderIngredient ("Pavo")
        case 5  :
            updateOrderIngredient ("Pepperoni")
        case 6  :
            updateOrderIngredient ("Pimiento")
        case 7  :
            updateOrderIngredient ("Piña")
        case 8  :
            updateOrderIngredient ("Salchicha")
        default : print("No selection");
        }
    }
    
    
}