({
	doInit : function(component, event, helper) {
		var quizList = component.get("c.getQuizList");        
        quizList.setParams({
            "contactId" : "0034P00002UxQt5"
        });
        quizList.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                var quizWrapper = response.getReturnValue();
                var optionList = [];
                for(var i=0;i<quizWrapper.length;i++){
                    var optionVal = {};
                    optionVal["label"] = quizWrapper[i].quizName;
                    optionVal["value"] = quizWrapper[i].quizId+"%%%%"+quizWrapper[i].junctionId;
                    optionList.push(optionVal);
                }
                
                component.set("v.quizMap",optionList);
            } 
        });
        
        $A.enqueueAction(quizList);
	},
    
        
    handleClick : function(component, event, helper) {
        component.set("v.showError", false);
        if(component.get("v.quizValue") === "" || component.get("v.quizValue") === undefined){
        
        component.set("v.showError", true);
        }
        else{
            var splitResult = component.get("v.quizValue").split("%%%%");
            component.set("v.quizValue", splitResult[0]);
            component.set("v.JunctionId", splitResult[1]);
            component.set("v.displayQuizscreen", true);
        }
    }
})