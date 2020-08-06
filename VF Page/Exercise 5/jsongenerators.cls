public with sharing class jsongenerators 
{
    public   string jsondata
    {
        get;
        set;
    }
    public list<jsonvalue> jsonstring 
    { 
        get; 
        set; 
    }
    public jsongenerators()
    {
        string soql ='SELECT Name, Industry FROM Account';
        List<Account> acct = Database.Query(soql);
        jsondata = JSON.serialize(acct);
        jsonstring = (List<jsonvalue>) System.JSON.deserialize(jsondata , List<jsonvalue>.class);
                
    }
    public class jsonvalue
    {
        public String name
        {
            get;
            set;
        }
        public String industry
        {
            get;
            set;
        }      
    }
}