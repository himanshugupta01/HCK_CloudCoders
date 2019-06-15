({
	handleLogin : function(component, event, helper) {
        component.set("v.showError", false);

		var validateUser = component.get("c.getContact");        
        validateUser.setParams({
            "username" : component.get("v.username"),
            "password" : component.get("v.password")
        });
        validateUser.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
               
                if(response.getReturnValue() !== "No Record") {
                component.set("v.contactValue", response.getReturnValue());
                component.set("v.displayScreen", false);
                }
                else{
                    component.set("v.showError", true);
                }
            } 
        });
        
        $A.enqueueAction(validateUser);
	}
})