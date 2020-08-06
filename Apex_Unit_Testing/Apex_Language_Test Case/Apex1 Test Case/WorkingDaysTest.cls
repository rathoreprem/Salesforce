@isTest
public class WorkingDaysTest 
{
    @isTest
    static void testNumberOfWorkingDaysPositiveCase()
    {
        Date startDate = Date.newInstance(2020, 5, 1);
        Date endDate = Date.newInstance(2020, 5, 10);
        Integer workDays = WorkingDays.WorkingDays(startDate, endDate);
        System.assertEquals(5, workDays);
    }
   
    @isTest
    static void testNumberOfWorkingDayWithSameDate()
    {
        Date startDate = Date.newInstance(2020, 5, 1);
        Date endDate = Date.newInstance(2020, 5, 1);
        Integer workDays = WorkingDays.WorkingDays(startDate, endDate);
        System.assertEquals(0, workDays);
     }
    
    @isTest
    static void testNumberOfWorkingDayNegativeCase()
    {
  
        Date startDate = Date.newInstance(2019, 5, 1);
        Date endDate = Date.newInstance(2019, 5, 1);
        Integer workDays = WorkingDays.WorkingDays(startDate, endDate);
        System.assertEquals(0, workDays);
    }
}