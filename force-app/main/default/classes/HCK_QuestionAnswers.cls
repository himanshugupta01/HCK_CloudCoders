public class HCK_QuestionAnswers{
    
    @AuraEnabled
    public static Boolean validateContact(string contactId,string quizId){
        List<HCK_JunctionContactQuiz__c> lstcCmQuiz = [SELECT Id FROM HCK_JunctionContactQuiz__c WHERE HCK_Contact__c =:contactId AND HCK_Quiz__c =:quizId ];
        if(lstcCmQuiz.Size() > 0 ) {
            return true ;
        }
        else {
            return false ;
        }
    }
    
    @AuraEnabled
    public static Boolean submitQuizQuestions(List<StudentselectedAnswer__c> userAnswers, HCK_JunctionContactQuiz__c quizObj) {
        
        //system.debug(quizObjId);
        //HCK_JunctionContactQuiz__c quizObj =  [Select id From HCK_JunctionContactQuiz__c Where id = :quizObjId Limit 1];
        //quizObj.HCK_Is_Taken__c = true;
        update quizObj;
        insert userAnswers;
        return true;
    }
    
    @AuraEnabled
    public static List<QustiAnsweWrapper > getQuizQuestions(string contactId,string quizId){
        Boolean isValidContact = validateContact(contactId,quizId);
        
        if(isValidContact ) {
            List<QustiAnsweWrapper> lstQAWrapper = new List<QustiAnsweWrapper>();
            set<Id> questionsId = new set<Id>();
            Map<Id,HCK_QuestionsAnswer__c> mapQuestionWithQA = new Map<Id,HCK_QuestionsAnswer__c>();
            List<HCK_JunctionQuizQuestion__c> lstQuizQuestion = [SELECT Id,HCK_Question__c FROM HCK_JunctionQuizQuestion__c Where HCK_Quiz__c =:quizId ];
            for(HCK_JunctionQuizQuestion__c objQuizQuest : lstQuizQuestion ) {
                questionsId.add(objQuizQuest.HCK_Question__c );
            }
            for(Question__c objQuestion : [select Id,QuestionValue__c,(Select Id,HCK_Answer__c,HCK_Answer__r.HCK_AnswerValue__c,Is_Correct__c,Question__c from HCK_QuestionsAnswers__r) from Question__c Where Id IN :questionsId  ]) {
                
            }
            for(Question__c objQuestion : [select Id,QuestionValue__c,(Select Id,HCK_Answer__c,HCK_Answer__r.HCK_AnswerValue__c,Is_Correct__c,Question__c from HCK_QuestionsAnswers__r) from Question__c Where Id IN :questionsId  ]) {
                QustiAnsweWrapper objQAWrpper = new QustiAnsweWrapper ();
                objQAWrpper.question = objQuestion ;
                objQAWrpper.quesOptions = objQuestion.HCK_QuestionsAnswers__r ;
                if(objQuestion.HCK_QuestionsAnswers__r.size() > 2) {
                    objQAWrpper.questionType = 'checkbox' ;
                }
                else {
                    objQAWrpper.questionType = 'radio';
                }
                lstQAWrapper.add(objQAWrpper);
            }
            
            
            /**for(HCK_QuestionsAnswer__c objQuestionAnswer : [Select Question__c,HCK_Answer__c from HCK_QuestionsAnswer__c Where Question__c In :questionsId ]) {
               if(mapQuesIdWithQuesAnswe.containsKey(objQuestionAnswer.Question__c)) {
                   mapQuesIdWithQuesAnswe.get(objQuestionAnswer.Question__c).add(objQuestionAnswer );
               }
               else {
                   mapQuesIdWithQuesAnswe.put(objQuestionAnswer.Question__c,new List<HCK_QuestionsAnswer__c >(objQuestionAnswer ));
               }
            }**/
            return lstQAWrapper  ;
        }
        else {
            return null;
        }
    }
    
    public class QustiAnsweWrapper {
    
        @AuraEnabled
        public Question__c question{get;set;}
        @AuraEnabled
        public List<HCK_QuestionsAnswer__c > quesOptions{get;set;}
        @AuraEnabled
        public String questionType{get;set;}
        
        
    
    }
    
}