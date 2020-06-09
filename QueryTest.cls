@isTest
public class QueryTest
{
    @testsetup
    static void testDataForQuery()
    {
        List<contact> newContacts = new List<contact>();
        for(Integer i = 0; i < 20; i++)
        {
            contact newContact = new contact(lastName = 'Test'+i);
            newContacts.add(newContact);
        }
        insert newContacts;
    }
    @isTest
    static void matchNumberOfRecords()
    {
        QueryComponentController qc= new QueryComponentController();
        qc.inputQuery='select id, lastname from contact';
        List<SObject> contact = qc.getQueryResult();
        system.assertEquals(20, contact.size());
    }
    
    @istest
    static void queryRecordWithWrongQuery()
    {
        QueryComponentController qc= new QueryComponentController();
        qc.inputQuery='select id, xyz from contact';
        List<SObject> contact = qc.getQueryResult(); 
        system.assertEquals(0, contact.size());
    } 
    @Istest
    static void fetchQueryRecord()
    {
        QueryComponentController qc= new QueryComponentController();
        qc.inputQuery='select id, Lastname from contact';
        List<SObject> contact = qc.getQueryResult();
        for(Integer i = 0; i < 20; i++)
        {
            system.assertEquals('Test'+i,contact[i].get('LastName'));
        }
    }
    
}