public inherited sharing class ReadingService {
    public List<Reading__c> searchReadings(Id authorId, String genre)
    {
        String queryStr='select Id, Name, Starts__c, Ends__c, Author__r.Name, Book__r.Name, Book__r.Genre__c from Reading__c ';

        String whereClause='';

        if (null!=authorId)
        {
            if (''!=whereClause)
            {
                whereClause+=' AND ';
            }
            whereClause+=' Book__r.Author__c=:authorId ';
        }

        if (!String.isBlank(genre))
        {
            if (''!=whereClause)
            {
                whereClause+=' AND ';
            }
            whereClause+=' Book__r.Genre__c=:genre ';
        }

        if (''!=whereClause)
        {
            queryStr+=' WHERE ' + whereClause;
        }

        List<Reading__c> readings=Database.query(queryStr);
        return readings;
    }
}
