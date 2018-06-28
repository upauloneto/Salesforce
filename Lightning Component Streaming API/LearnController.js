({
    init: function (component, event, helper) {
         helper.startListening(component, event, helper);
    },
    handleShowNotificationEvent: function (component, event, helper) {
        helper.handleShowNotificationEvent(component, event, helper);
    },
    // Navega entre páginas Lightning
    goto : function(component, event, helper){
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
          "recordId": event.target.lang,
          "slideDevName": "related"
        });
        navEvt.fire();
    }
})