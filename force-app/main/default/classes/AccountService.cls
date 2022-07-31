global class AccountService{
    webservice static String CreateCustomber( String Name, String Phone, String City)
    {
        Account objA= new Account();
        objA.Name= Name;
        objA.Phone= Phone;
        objA.BillingCity= City;
        Insert objA;
        
        if(objA!=NULL)
         { 
           return'success';
          }
         else 
          {
            return'failure';
            
           }
    }
}