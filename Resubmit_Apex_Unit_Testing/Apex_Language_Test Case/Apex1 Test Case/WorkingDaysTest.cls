@isTest
private class WorkingDaysTest 
{
    @isTest
    static void testNumberOfWorkingDays_WithDifferentDate()
    {
        Date startDate = Date.newInstance(2020, 5, 1);
        Date endDate = Date.newInstance(2020, 5, 10);
        Integer workDays = WorkingDays.WorkingDays(startDate, endDate);
        System.assertEquals(5, workDays);
    }
   
    @isTest
    static void testNumberOfWorkingDay_WithSameDate()
    {
        Date startDate = Date.newInstance(2020, 5, 1);
        Date endDate = Date.newInstance(2020, 5, 1);
        Integer workDays = WorkingDays.WorkingDays(startDate, endDate);
        System.assertEquals(0, workDays);
     }
    
    @isTest
    static void testNumberOfWorkingDay_StartDaySunday_EndDayMonday()
    {
  
        Date startDate = Date.newInstance(2020, 5, 2);
        Date endDate = Date.newInstance(2020, 5, 4);
        Integer workDays = WorkingDays.WorkingDays(startDate, endDate);
        System.assertEquals(-2, workDays);
    }
}