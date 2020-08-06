@isTest
public class StudentLimitsInClassTest 
{
    /**
     * Add Students more then the class max size
     */
    @isTest
    static void studentLimitsInClassTestWithMoreThanLimit()
    {
        TestDataFactory data = new TestDataFactory();
        List<Class__c> newClasses = data.newClasses;
        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 36; i++)
        {
            Class__c cls = newClasses[0];
            system.debug(cls.Id);
            Student__c newStudent = new Student__c(Name = 'Name'+i, LastName__c = 'Last', Class__c = cls.Id, Sex__c = 'Male');
        	students.add(newStudent);
        }
        Test.startTest();
        Database.SaveResult[] result = Database.insert(students, false);
        Test.stopTest();
        Class__c clss= [SELECT Id, MyCount__c 
                        FROM Class__c 
                        WHERE Name = 'Class0'];
        System.assertEquals(5, clss.MyCount__c);
    }
    
    /**
     * Add Students less then the class max size
     */
    @isTest
    static void studentLimitsInClassTestWithLessThanLimit()
    {
        TestDataFactory data = new TestDataFactory();
        List<Class__c> newClasses = data.newClasses;
        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 20; i++)
        {
            Class__c cls = newClasses[0];
            Student__c newStudent = new Student__c(Name = 'Name'+i, LastName__c = 'Last', Class__c = cls.Id, Sex__c = 'Male');
            System.debug(newStudent.Name);
            System.debug(newStudent.Class__c);
            students.add(newStudent);
        }
        Test.startTest();
        Database.SaveResult[] result = Database.insert(students, false);
        Test.stopTest();
        System.debug(result.size());
        Class__c cls= [SELECT Id, MyCount__c, Maxsize__c 
                       FROM Class__c 
                       WHERE Name = 'Class0'];
        if(cls.MaxSize__c > cls.MyCount__c)
        {
        	System.debug('Succesfully data insert');
        }
        else
        {
			System.debug('Data not Succesfully insert');            
        }
    }
}