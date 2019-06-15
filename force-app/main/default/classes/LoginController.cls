public class LoginController{
    
    @AuraEnabled
    public static string getContact(string username,string password){
        List<contact> conList = [select id from contact where username__c=:username and password__c=:password];
        if(conList.size() > 0)return string.valueof(conList[0].id);
        else return 'No Record';
    }
}