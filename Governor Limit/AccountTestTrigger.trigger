trigger AccountTestTrigger on Account (before insert, before update) {
    
    List<Contact> contactsList = new List<Contact>();
    for (Account acc :[Select id,(Select id,salutation, firstname, lastname, email from Contacts) from Account where Id In : Trigger.newMap.KeySet() ]) {  
        for (Contact cnt : acc.Contacts) {  
            contactsList.add(cnt);
        }       
    }
    update contactsList;
}