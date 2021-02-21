public inherited sharing class BookstoreWithReadingsSampleData 
{
    static List<String> Names=new List<String>
                {'Lockdown Look-See',
                'Circuit Break Escape', 
                'Distanced Diction',
                'Tier 4 Tears',
                'Shelter Skelter',
                'Firebreak Fireworks'
                };

    public static void CreateBookstoreSampleData()
    {
        BookstoreSampleData.CreateBookstoreSampleData();
        List<Author__c> authorsByName=new List<Author__c>();

        DateTime baseStart=DateTime.newInstance(System.today(), Time.newInstance(17, 0, 0, 0));
        DateTime baseEnd=DateTime.newInstance(System.today(), Time.newInstance(18, 0, 0, 0));

        List<Reading__c> readings=new List<Reading__c>();
        Integer idx=0;
        for (Author__c author : [select id, Name, (select id, Name from Books__r) from Author__c])
        {
            for (Book__c book : author.Books__r)
            {
                Reading__c reading=new Reading__c(Name=Names[idx],
                                         Author__c=author.Id,
                                         Book__c=book.Id,
                                         Starts__c=baseStart.addDays(idx*6),
                                         Ends__c=baseEnd.addDays(idx*6));

                readings.add(reading);

                idx++;
                if (idx>2)
                {
                    break;
                }
            }
            if (idx>2)
            {
                break;
            }
        }

        insert readings;
    }

    public static void RemoveBookstoreSampleData()
    {
        List<Reading__c> readings=[select id from Reading__c];
        delete readings;

        BookstoreSampleData.RemoveBookstoreSampleData();
    }
}
