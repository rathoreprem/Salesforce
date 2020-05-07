@isTest
public class RestrictHindiTeacherTest 
{
   /**
     * Here 2 hindi teacher and 18 other non hindi teacher will inserted 
     * So only 18 teacher will getting inserted
     */
    @isTest
    static void restrictHindiTeacherWhenInsert()
    {
        TestDataFactory data = new TestDataFactory();
        List<Contact> newTeachers = data.newTeachers;
        List<Class__c> newClasses = data.newClasses;
        
        List<Teach__c> newTeaches = new List<Teach__c>();
        for(Integer i = 0; i < 20; i++)
        {
            Teach__c newTeach = new Teach__c(Teacher__c = newTeachers[i].Id, Class__c = newClasses[i].Id, Subject__c = 'Maths');
            newTeaches.add(newTeach);
        }
        newTeaches[0].Subject__c = 'Hindi;English';
        newTeaches[15].Subject__c = 'Hindi;Science';
        Test.startTest();
        Database.SaveResult[] result = Database.insert(newTeaches, false);
        Test.stopTest();
        List<Teach__c> teach= [SELECT Id 
                               FROM Teach__c];
        System.assertEquals(18, teach.size());
    }
    
    /**
     * Here all teacher teaches hindi so no teacher will getting  inserted
     */
    @isTest
    static void restrictHindiTeacherTestWhenAllTeachsHindi()
    {
        TestDataFactory data = new TestDataFactory();
        List<Contact> newTeachers = data.newTeachers;
        List<Class__c> newClasses = data.newClasses;
        List<Teach__c> newTeaches = new List<Teach__c>();
        for(Integer i = 0; i < 20; i++)
        {
            Teach__c newTeach = new Teach__c(Teacher__c = newTeachers[i].Id, Class__c = newClasses[i].Id, Subject__c = 'Hindi;English');
            newTeaches.add(newTeach);
        }
        Test.startTest();
        Database.SaveResult[] results = Database.insert(newTeaches, false);
        Test.stopTest();
        System.debug(results.size());
        for(Database.SaveResult result : results)
        {
            List<Teach__c> teach = [SELECT Id 
                                    FROM Teach__c];
            System.assertEquals(0, teach.size());     
        }
    }


    /**
     * Here all teacher by default teaches English 
     * Update english with hindi but no record can update with hindi
     */
    @isTest
    static void restrictHindiTeacherTestForUpdate()
    {
        TestDataFactory data = new TestDataFactory();
        List<Contact> newTeachers = data.newTeachers;
        List<Class__c> newClasses = data.newClasses;
        List<Teach__c> newTeaches = new List<Teach__c>();
        for(Integer i = 0; i < 20; i++)
        {
            Teach__c newTeach = new Teach__c(Teacher__c = newTeachers[i].Id, Class__c = newClasses[i].Id, Subject__c = 'English');
            newTeaches.add(newTeach);
        }
        insert newTeaches;
        Test.startTest();
        newTeaches[0].Subject__c = 'Hindi';
        newTeaches[15].Subject__c = 'Hindi';
        Database.SaveResult[] results = Database.update(newTeaches, false);
        Test.stopTest();
        List<Teach__c> teach= [SELECT Id FROM Teach__c];System.assertEquals(20, teach.size());
	}
}