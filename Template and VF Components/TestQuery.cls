@isTest
public class TestQuery 
{
    @testsetup
    static void TestQuery()
    {
        List<contact> newClasses = new List<contact>();
        for(Integer i = 0; i < 20; i++)
        {
            contact newClass = new contact(lastName = 'Class'+i);
            newClasses.add(newClass);
        }
        insert newClasses;
    }
    @isTest
    static void matchNumberOfRecords()
    {
        QueryComponentController qc= new QueryComponentController();
        qc.inputQuery='select id, lastname from contact';
        List<SObject> classs = qc.getQueryResult();
        system.assertEquals(20, classs.size());
    }
    
    @istest
    static void queryRecordWithWrongQuery()
    {
        QueryComponentController qc= new QueryComponentController();
        qc.inputQuery='select id, xyz from contact';
        List<SObject> classs = qc.getQueryResult(); 
        system.assertEquals(0, classs.size());
    } 
    @istest
    static void fetchQueryRecord()
    {
        QueryComponentController qc= new QueryComponentController();
        qc.inputQuery='select id, Lastname from contact';
        List<SObject> classs = qc.getQueryResult();
        for(Integer i = 0; i < 20; i++)
        {
            system.assertEquals('Class'+i,classs[i].get('LastName'));
        }
    }
    
}