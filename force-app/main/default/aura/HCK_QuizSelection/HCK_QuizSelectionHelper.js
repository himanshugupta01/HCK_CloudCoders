({
	showToast : function(component, event, helper) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": "Error!",
        "message": "Please select an option",
        "type" : "warning"
    });
    toastEvent.fire();
}
})