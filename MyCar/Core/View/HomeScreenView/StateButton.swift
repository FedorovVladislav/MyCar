import Foundation

struct StateButton {
    
    let typeButton : DataCarEquipment
    
    let tupeObjectName : String
    let stateOnName : String
    let stateOffName : String
    let iconOnName : String
    let iconOffName : String
    
    init (tupeObjectName: String, stateOnName : String, stateOffName : String, iconOnName : String, iconOffName : String,typeButton: DataCarEquipment  ){
        self.tupeObjectName = tupeObjectName
        self.stateOnName = stateOnName
        self.stateOffName = stateOffName
        self.iconOnName = iconOnName
        self.iconOffName = iconOffName
        self.typeButton = typeButton
    }
}
