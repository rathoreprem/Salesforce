public class StudentDeleteRemote {
    
    public List<Id> studentIdList { get; set; }
    public StudentDeleteRemote() { } // empty constructor
    
    @RemoteAction
    public static boolean deleteStudent(List<Id> studentIdList) {
        List<Student__c> studentList = [SELECT Id,Name From Student__c WHERE id in:studentIdList];
        Database.DeleteResult[] deleteResultList = Database.delete(studentList);
        for(Database.DeleteResult deleteRecord : deleteResultList)
        {
			if(deleteRecord.isSuccess() == false)
            {
                return false;
            }
        }
        return true;
    }
}