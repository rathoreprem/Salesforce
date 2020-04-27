public class JobSchedule {
 public static void scheduleJob(){
        OppOwnerMail reminder = new OppOwnerMail();
        String cron = '20 30 8 10 2 ?';
        String jobID = System.schedule('Opportunity Update mail to owner', cron, reminder);
    }
}