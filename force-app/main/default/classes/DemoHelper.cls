public class DemoHelper {
    @AuraEnabled
    public static List<Account> myMethod(){
       return [SELECT Name, Type, Fax, Phone FROM Account];
    } 
}