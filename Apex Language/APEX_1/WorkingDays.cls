public class WorkingDays 
{
    public static Integer workingDays(Date startDate, Date lastDate)
    {
       Integer workDays = startDate.daysBetween(lastDate) - 1;
       Datetime start = DateTime.newInstance(startDate, Time.newInstance(0, 0, 0, 0));
	   String startDay=start.format('EEEE');
       Datetime last = DateTime.newInstance(lastDate, Time.newInstance(0, 0, 0, 0));
	   String lastDay=last.format('EEEE');
       
       if(startDay=='Saturday')
       {
           workDays -= 1;
       }
       if(startDay=='Friday')
       {
           workDays -= 2;
       }
       if(lastDay=='Sunday')
       {
           workDays -= 1;
       }
       if(lastDay=='Monday')
       {
           workDays -= 2;
       }
       Integer days = (workDays/7);
       days = days*2;
       return workDays-days;
   }
}