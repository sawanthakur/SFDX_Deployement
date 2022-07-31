public class trigger_class {
public static void check_opp(List<Opportunity> ops) {
double total_amount=0;
for(Opportunity o1 :[Select Amount from opportunity where createddate=Today AND createdbyID= :UserInfo.getUserID()])
{
     total_amount += o1.Amount;
}
for(opportunity o2: ops)
{
 total_amount += o2.Amount;
 o2.adderror('You have Excceded daily Limit');
 }
}

}