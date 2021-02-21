public inherited sharing class ReadingsController {
    @AuraEnabled(cacheable=true)
    public static List<Reading__c> searchReadings(String author, String genre)
    {
        List<Reading__c> result=null;
        try 
        {
            Id authorId=null;

            if (!String.isBlank(author)) 
            {
                authorId=(Id) author;
            }
            result=new ReadingService().SearchReadings(authorId, genre);
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }

        return result;
    }
}
