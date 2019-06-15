({
	setupQuizScreen : function(component) {
		let quizId = component.get("v.quizId");
        let contactId = component.get("v.contactId");
        if(quizId && contactId) {
            let action = component.get("c.getQuizQuestions");
            //component.set("v.siteId", siteId);
            action.setParams({"quizId":quizId, "contactId":contactId});  
	        action.setCallback(this, function(response){  
	        	var state = response.getState(component, event);
	            if (state === "SUCCESS" && response.getReturnValue()) {	
                    component.set("v.allQuizData",response.getReturnValue());
                    //this.showScreenQuiz();
	            } else {
					/**Will display error on Toast screen */
                    this.displayError("Quiz not assigned");
	            }
            });
            $A.enqueueAction(action);             
        }		
	},
    showScreenQuiz : function() {
		let quizId = component.get("v.quizId");
        let contactId = component.get("v.contactId");        
    },
   /** Method used for displaying Error message on toast screen. **/
    displayError : function(messageDefault) {
    	var toastParams = {
							title: "Error",
							message: messageDefault, // Default error message
							type: "error"
						};		 
		this.showToast(toastParams);    
    },
    /** Method used for displaying Error message on toast screen. **/
    displaySuccess : function(messageDefault) {
    	var toastParams = {
							title: "Success",
							message: messageDefault, 
							type: "Success"						
        				};
		this.showToast(toastParams);    
    },
    saveQuiz : function(component) {
        const myCheckboxes = component.find('answerField'); 
    	let chk = (myCheckboxes.length == null) ? [myCheckboxes] : myCheckboxes;
        let userAnswers= chk.reduce((acc, checkbox) => { 
            if(checkbox.get('v.checked')){
            	acc.push(Object.assign({}, {"QuestionsAnswer__c":checkbox.get('v.value'), "Quiz__c":component.get("v.quizId"), "Student__c":component.get("v.contactId")}));
        	}
    		return acc;
        	},[]
       	);
        if(userAnswers) {
            let action = component.get("c.submitQuizQuestions");
            //component.set("v.siteId", siteId);
            //action.setParams({"userAnswers":userAnswers, "quizObjId":component.get("v.junction")});
            action.setParams({"userAnswers":userAnswers, "quizObj":{"HCK_Is_Taken__c":true, "Id":component.get("v.junction")}});   
	        action.setCallback(this, function(response){  
	        	var state = response.getState(component, event);
	            if (state === "SUCCESS" && response.getReturnValue()) {	
                    alert('submit');
                    component.set("v.showSummary", true);
                    //component.set("v.allQuizData",response.getReturnValue());
                    //this.showScreenQuiz();
	            } else {
					/**Will display error on Toast screen */
                    //this.displayError("Quiz submit error");
	            }
            });
            $A.enqueueAction(action);   			           
        }
  }
        //component.find
    //}    
})