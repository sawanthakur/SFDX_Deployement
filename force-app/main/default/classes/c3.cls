public class c3
{
Account[] selectedacts;
public Account[] getselectedacts()
{
return selectedacts;
}
public PageReference showall()
{
selectedacts= [select Name,Type, Industry, Phone, Fax from Account];
return null;
}
public PageReference direct()
{
selectedacts= [select Name,Type, Industry, Phone, Fax from Account where Type='Customber - Direct'];
return null;
}

}