({
    handleOnSuccess : function(component, event, helper) {
        component.set("v.showForm", false);
        var param = event.getParams(); //get event paramscccc
        var fields = param.response.fields; //get all field info
        var recordId = param.response.id;
        var FirstName = param.response.FirstName;
        component.set('v.recordId', recordId);
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been created successfully."
        });
        toastEvent.fire();
    },
   
    handleOnError : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: "Error!",
            message: "Error on save",
            type: "Error"
        });
        toastEvent.fire();
    }
})