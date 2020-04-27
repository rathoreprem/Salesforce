public class AccountUtil {
    public static void storeContactIds(Id contactId){
    	Contact contact = [SELECT accountid FROM Contact WHERE id =: contactId];
        Account accountContactIds = [SELECT id, ContactIDs__c FROM account WHERE id =: contact.AccountId];
        if (accountContactIds.ContactIDs__c == null){
            List<Contact> contactIdList = [SELECT id FROM contact WHERE accountid =: accountContactIds.id];
            String newContactIds = '';
            for(Contact cntObj : contactIdList){
                newContactIds += cntObj.id + ',';
            }
            accountContactIds.ContactIDs__c = newContactIds.removeEnd(',');
        }
        else
            if (!(accountContactIds.ContactIDs__c.contains(contactId))){
                accountContactIds.ContactIDs__c += ',' + contactId;
            }
        update accountContactIds;
    }
}