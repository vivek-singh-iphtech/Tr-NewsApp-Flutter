

class ApiUrl
{
  
    static String Base_URL = 'https://newsapi.org/v2';

    static String ApiKey = '560ae2ee4f4544568d47834ac609de0c';
    // static String ApiKey = '92d3fe73ab0e4f9c8f170648f463ca8d';
    // static String ApiKey = '81a0b2956c214ccc9f802808ce106de5';

    static String Top_headLines = '/top-headlines?country=in&apiKey=$ApiKey&category=';

    static String categoryHeadline = '/top-headlines?country=in&apiKey=$ApiKey&category=';

    static String channelSources = '/top-headlines/sources?country=us&apiKey=$ApiKey';

    static String NewsByChannelSources = '/top-headlines?apiKey=$ApiKey&sources=';

    static String ToDate = '&to=';

    static String FromDate = '&from=';

    static String sortBy = '&sortBy=';

    static String EveryNews = '/everything?apiKey=$ApiKey&q=';

}