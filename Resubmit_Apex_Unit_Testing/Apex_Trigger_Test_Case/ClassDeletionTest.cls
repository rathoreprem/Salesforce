@isTest
public class ClassDeletionTest 
{
    /***
     * This test case is with 3 females. 2 are in same class and one in the other class.
     * so more then 1 females class will not be deleted, after deletion we will see 1 class
     */
    @isTest
    static void classDeletionWith3Female()
    {
        TestDataFactory data = new TestDataFactory();
        List<Class__c> classes = data.newClasses;
    	List<Student__c> students = data.newStudents;
        students[0].Sex__c = 'F';
        students[1].Sex__c = 'F';
        students[21].Sex__c = 'F';
        update students;
        Test.startTest();
        Database.DeleteResult[] result = Database.delete(classes, False);
        Test.stopTest();
        List<Class__c> cls = [SELECT Id FROM Class__c];
        System.assertEquals(1, cls.size());
    }
    
    /***
     * This test case is with 80 females. Every class having 4 female students.
     * So no class getting deleted.
     */
    @isTest
    static void classDeletionWith80Female()
    {
        TestDataFactory data = new TestDataFactory();
        List<Class__c> classes = data.newClasses;
    	List<Student__c> students = data.newStudents;
        for(Integer index = 0; index < 80; index++)
        {
            students[index].Sex__c = 'F';
        }
        update students;
        Test.startTest();
        Database.DeleteResult[] result = Database.delete(classes, false);
        Test.stopTest();
        List<Class__c> cls = [SELECT Id FROM Class__c];
        System.assertEquals(20, cls.size());
    }
    
    /***
     * This test case is with 0 females.
     * So all classes will be deleted.
     */
    @isTest
    static void classDeletionWithNoFemale()
    {
        boolean checkError = true;
        TestDataFactory data = new TestDataFactory();
        List<Class__c> classes = data.newClasses;
    	List<Student__c> students = data.newStudents;
        Test.startTest();
         Database.DeleteResult[] results = Database.delete(classes, false);
        Test.stopTest();
        List<Class__c> cls = [SELECT Id FROM Class__c];
        for(Database.DeleteResult result : results)
        {
            if(cls.size() > 0)
            {
                System.assertEquals(true, result.issuccess());
        	}
        else
        	{
           		System.assertNotEquals(false, result.issuccess()); 
        	}
        } 
    }
}