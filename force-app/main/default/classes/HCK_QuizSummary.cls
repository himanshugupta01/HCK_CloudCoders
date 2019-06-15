public class HCK_QuizSummary{
    
    @AuraEnabled
    public static string getselectedAnswers(String candidateId, string QuizId){ 
    map<string,set<string>> answerList = new map<string,set<string>>();
    set<string> junctionId = new set<string>();
        List<StudentselectedAnswer__c> answerListVal = [select Quiz__c,QuestionsAnswer__c,QuestionsAnswer__r.Question__c,QuestionsAnswer__r.HCK_Answer__c from StudentselectedAnswer__c where Quiz__c =:QuizId and Student__c=:candidateId];
        for(StudentselectedAnswer__c ans : answerListVal){
            junctionId.add(ans.QuestionsAnswer__r.Question__c);
            if(answerList.keyset().contains(ans.QuestionsAnswer__r.Question__c)){
                answerList.get(ans.QuestionsAnswer__r.Question__c).add(ans.QuestionsAnswer__r.HCK_Answer__c);
            }
            else{
                set<string> answerValues = new set<string>();
                answerValues.add(ans.QuestionsAnswer__r.HCK_Answer__c);
                answerList.put(ans.QuestionsAnswer__r.Question__c,answerValues);
            }
        }
        
        map<string,list<string>> actualAnswerList = new map<string,list<string>>();
        List<HCK_QuestionsAnswer__c> questionList = new List<HCK_QuestionsAnswer__c>();
        questionList = [select Question__c,HCK_Answer__c,Is_Correct__c from HCK_QuestionsAnswer__c where Question__c IN :junctionId and Is_Correct__c=true];
        for(HCK_QuestionsAnswer__c actualAns: questionList) {
            if(actualAnswerList.keyset().contains(actualAns.Question__c)){
                actualAnswerList.get(actualAns.Question__c).add(actualAns.HCK_Answer__c);
            }
            else{
                list<string> answerValues = new list<string>();
                answerValues.add(actualAns.HCK_Answer__c);
                actualAnswerList.put(actualAns.Question__c,answerValues);
            }
        }
        
        Integer totalQuestions = actualAnswerList.keyset().size();
        Integer correctAnswers = 0;
        for(string question : actualAnswerList.keyset()){
            system.debug(question);
            system.debug(answerList.get(question)+'   '+answerList.keyset());
            system.debug(actualAnswerList.get(question)+'   '+actualAnswerList.keyset());           
            if(answerList.get(question).containsall(actualAnswerList.get(question))) {
                correctAnswers = correctAnswers+1;
            }
        }
        
        return string.valueof(totalQuestions)+'%%%%'+string.valueof(correctAnswers);
    }
    
}