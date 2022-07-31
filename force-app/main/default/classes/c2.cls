public class c2
{
List<Account> acts= [Select Name,Type, Industry, Phone, Fax from Account where Industry='Energy'];
public List<Account> getacts(){
return acts;
}
}