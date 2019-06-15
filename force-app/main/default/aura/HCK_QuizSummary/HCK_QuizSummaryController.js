({
	doInit : function(component, event, helper) {
		var action = component.get("c.getselectedAnswers");
        action.setParams({
            "candidateId" : component.get("v.candidateId"),
            "QuizId" :component.get("v.QuizId")
        });
        action.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
                
                var responseValue = response.getReturnValue().split('%%%%');
                component.set("v.totalQuestions", responseValue[0]);
                component.set("v.correctAnswers", responseValue[1]);
            }
        });
        
        $A.enqueueAction(action);
        
	}
})