trigger phoneupdateoncontact on Account (after update) {
for(Account acc: trigger.new)
 { 
    List<Contact> listcon=[Select phone from contact where Accountid=: acc.id];
    for(Contact con: listcon)
     {
       con.phone=acc.phone;
      }
   update listcon;
  } 

}