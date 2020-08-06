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
    static void studentLimitsInClassTest_whenClassHaveSpace_insertStudnetSuccessfully()
    {
        // GIVEN
        List<Class__c> newClasses = TestDataFactory.createClass(5, 30);
        Class__c cls = newClasses[0];
        TestDataFactory.createMaleStudentForClass(cls.Id, 10);
    
        
        Test.startTest();
        // WHEN
        List<Student__c> extraStudents = new List<Student__c>();
        for(Integer i = 0; i < 20; i++)
        {
            Student__c newStudent = new Student__c(Name = 'Name'+i, 
                                                   LastName__c = 'Last', 
                                                   Class__c = cls.Id, 
                                                   Sex__c = 'M');
            
            extraStudents.add(newStudent);
        }
        insert extraStudents;
        Test.stopTest();
        // THEN student successfully inserted.
    }
    
    @isTest
    static void studentLimitsInClassTest_whenClassDontHaveSpace_throwException()
    {
        // GIVEN
        List<Class__c> newClasses = TestDataFactory.createClass(5, 30);
        Class__c cls = newClasses[0];
        TestDataFactory.createMaleStudentForClass(cls.Id, 30);
    
        
        Test.startTest();
        // WHEN
        Student__c extraStudent = new Student__c();
        extraStudent.Name = 'Name';
        extraStudent.LastName__c = 'Last';
		extraStudent.Class__c = cls.Id;
        extraStudent.Sex__c = 'M';
        
        try {
            insert extraStudent;
            System.assert(false, 'student should not be inserted');
        } catch (DMLException e) {
           // THEN
            System.assertEquals(
                'Class size is Full. Please select another class', 
                e.getDmlMessage(0), 
                'wrong error message received.'
            );
        }
        
        Test.stopTest();
    }
}