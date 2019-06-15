public class HCK_QuizController{
    
    @AuraEnabled
    public static List<quizWrapper> getQuizList(string contactId){
        
        set<string> quizIds = new set<string>();
        List<quizWrapper> quizMapping = new List<quizWrapper>();
        for(HCK_JunctionContactQuiz__c quizCon : [select HCK_Quiz__c,HCK_Quiz__r.Name,Id from HCK_JunctionContactQuiz__c where HCK_Contact__c = :contactId and HCK_Is_Taken__c=false]){
            
            quizMapping.add(new quizWrapper(string.valueof(quizCon.HCK_Quiz__c),string.valueof(quizCon.HCK_Quiz__r.name),string.valueof(quizCon.Id)));

        }
        
        return quizMapping;
    }
    
    public class quizWrapper{
        
        @AuraEnabled
        public string quizId{get;set;}
        @AuraEnabled
        public string quizName{get;set;}
        @AuraEnabled
        public string junctionId{get;set;}
        
        public quizWrapper(string idValue, string nameValue,string juncId){
            quizId = idValue;
            quizName=nameValue;
            junctionId = juncId;
        }
    }
}