# Abstractedly - A readme

### The concept:

Abstractedly is a simple, lightweight Rails app that helps scientists and other scholarly journal readers to more easily view and organize abstracts of recent articles. Abstracts are summaries of highly complex articles that are published in scholarly journals. These journals' websites makes it difficult for viewers to quickly view all of the abstracts in a given journal issue. In some cases, only one abstract is visible on each page, requiring dozens of clicks and page loads to move through an entire issue.

Abstractedly was the idea of a scientist, specifically to look up abstracts published by nuclear medicine journals. However, its structure and principals work for every scholarly journal, ranging from sociology to literary criticism publications.

### How it works:

Abstractedly uses the FeedJira gem to make a GET request to a journal's RSS feed, which helpfully contain the body, title, author, and other attributes of the abstract model. Abstracts belong to a given journal issue - identifiable by its publication date and issue number. Journals in turn belong to the journal feed, which represents the homepage of the publication itself.

Logic in the Scraper class checks if a journal issue has already been scraped from the journal feed. If it hasn't, it collects the abstracts from the journal feed, and instantiates a journal with the associated abstracts. Abstractedly uses a rake task to check for new journal issues several times a day.

The user and journal feed have a has_many relationship, and are connected through the subscription model. Subscriptions can be created and deleted easily in order to filter the visible abstracts.

Scraping RSS feeds is quite time consuming - as Abstractedly's catalogue of journal feeds continues to grow, the process has greatly slowed down. Fortunately, the scraping occurs in the background except when a new journal feed is added by a user. In that case, I added logic to only scrape the new feed, greatly speeding up the process.

### Problems:

Abstractedly's database stores journals and their abstracts, and as the app's catalogue grew so did the size of the queries that were required to load certain views. Almost immediately the app ground to a halt as my code made hundreds of database queries for a single load. I replaced this logic with an ActiveRecord query that eagerly loads the necessary journal feeds, and its associated journals => abstracts with a single query. The result is a much faster application.

```ruby
def index
  #Journal Feeds view only displays subscribed feeds.
  @journal_feeds = JournalFeed.joins(:subscriptions)
  .where('subscriptions.user_id' => current_user.id)
  .includes({:journals => :abstracts})
  .sort_by {|feed| feed.latest_journal.date}.reverse
end
```

.joins, .where, and .sort_by are standard SQL queries. .includes is a nifty Rails method that loads a model's associations 'eagerly' - that is, it gathers them from the database before they are needed in a single query. The  slower method that most Ruby on Rails users are taught for simplicity's sake is to iterate through each collection, querying the database for each model. This leads to hundreds of queries and slows the application to a crawl.

Abstractedly's greatest problem is the size of its database - it quickly fills up and requires larger database storage on a regular basis. There are a few things I can do to constrain new models from being created - such as storing keywords in an array rather than them being individual models. Ultimately I will need a very large database, as journals and abstracts do not become 'stale' or unusable as they become older. The user can choose to sort through abstracts that are current, or go through the archives to access older abstracts as well. 

###### Keywords:

Abstracts have_many keywords - these act as tags/hashtags to better group abstracts of the same topic. Irritatingly, the keywords are not listed on the RSS feed. While this made obtaining the keywords more complicated, it was also a great chance to add a valuable feature to Abstractedly. RSS readers, which are probably Abstractedly's closest competitors, won't have keywords available to them. As a result, Abstractedly has an advantage - it allows abstracts from a wide variety of journals to be sorted by keyword.

Mining the keywords was reasonably straightforward. The RSS feed lists a URL for each abstract, which helpfully points to a website where keywords are displayed. I used the Mechanize Gem to direct a GET request to each URL. Given the large number of abstracts, this is a time consuming process! However, it occurs in the background of the application and does not interfere with the user experience.

###### What if there's no keywords?

The above is not a complete solution because some abstracts do not list keywords even once. An upcoming feature I'm working on is to gather keywords from the abstract itself. This strikes me as a relatively straightforward process - compare the content of an abstract (and its title) to a list of banned, common words (the, it, they, etc.). The remaining words are weighted by how often they appear, with the most common words becoming keywords.

###### Creating new journal feeds.

~~A significant pain point for the application: setting up a new journal feed requires a new method be added to the Adapter class. Given how similar the structure of each journal feed is, I feel like an automated or greatly simplified process is within my abilities. I'd like to explore more journal feeds and their structures before I tackle that though.~~

Users can now create their own journal feeds. The process will generally catch invalid urls, but it's not perfect. It requires the RSS url be copied and pasted. Existing RSS readers already have access to a large database of RSS feeds so the user can choose which feeds to access without creating a new one. After some research into how RSS readers work, I'm not quite sure how one accesses these databases. There's thousands of scientific journals out there, so I need a systematic way to access them.

RSS feeds are structured different from site to site, and Abstractedly requires robust logic to successfully create and populate a journal with abstracts. Thankfully the RSS scraping tool Feedjira is easily customizable after a little poking about into how it works.

Ultimately the abstracts don't have to look perfect, but their overall formatting should be relatively seamless. Some basic formatting, such as removing line breaks and repetitive headers (such as abstract: or summary:) helps immensely.


### Developer and User stories:
- ~~The User can create custom keywords~~ Completed!
- ~~The User can view abstracts that share a custom keyword~~ Completed!
- ~~The developer improves site speed by reducing the number of database queries and limiting elements that are displayed on each view~~ Completed!
- The User can search journals by a certain date, or range of dates
- ~~The User can add new journal feeds on their own~~ Completed!
- ~~The User can search abstracts by keyword~~ Completed!
- The User can choose to search the entire Abstractedly database by keyword, or simply the feeds they have subscribed to.
