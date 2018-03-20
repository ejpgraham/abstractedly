# Abstractedly - A readme

### The concept:

Abstractedly is a simple, lightweight Rails app that helps scientists and other scholarly journal readers to more easily view and organize abstracts of recent articles. Abstracts are summaries of highly complex articles that are published in scholarly journals. These journals' websites makes it difficult for viewers to quickly view all of the abstracts in a given journal issue.

Abstractedly was the idea of a scientist, specifically to look up abstracts published by nuclear medicine journals. However, its structure and principals work for every scholarly journal, ranging from sociology to literary criticism publications.

### How it works:

Abstractedly uses the FeedJira gem to make a GET request to a journal's RSS feed, which helpfully contain the body, title, author, and other attributes of the abstract model. Abstracts belong to a given journal issue - identifiable by its publication date and issue number. Journals in turn belong to the journal feed, which represents the homepage of the publication itself.

Logic in the Scraper class checks if a journal issue has already been scraped from the journal feed. If it hasn't, it collects the abstracts from the journal feed, and instantiates a journal with the associated abstracts. Abstractedly uses a rake task to check for new journal issues several times a day.

The user and journal feed have a has_many relationship, and are connected through the subscription model. Subscriptions can be created and deleted easily in order to filter the visible abstracts.

### Problems:

###### Keywords:

Abstracts have_many keywords - these act as tags/hashtags to better group abstracts of the same topic. Irritatingly, the keywords are not listed on the RSS feed. While this made obtaining the keywords more complicated, it was also a great chance to add a valuable feature to Abstractedly. RSS readers, which are probably Abstractedly's closest competitors, won't have keywords available to them. As a result, Abstractedly has an advantage - it allows abstracts from a wide variety of journals to be sorted by keyword.

Mining the keywords was reasonably straightforward. The RSS feed lists a URL for each abstract, which helpfully points to a website where keywords are displayed. I used the Mechanize Gem to direct a GET request to each URL. Given the large number of abstracts, this is a time consuming process! However, it occurs in the background of the application and does not interfere with the user experience.

 Mechanize returns an easily navigable object containing the information I want - the keyword bodies. I find that different journals used different HTML containers and class names, but the structure is simple enough that a classname as a string can locate the keyword for each abstract.

###### What if there's no keywords?

As I looked into more journals, I found that some of them did not provide keywords at all - even on the abstract page. This is a significant problem because abstracts without keywords miss out on some of my great keyword functionality!

I added a new keyword model, the custom_keyword, that users can create and tag abstracts with. They are unique to each user, but otherwise have the same functionality as a keyword. This is a nice feature, but isn't quite enough to solve the keyword problem in my view.

I would also like the application to automatically generate keywords based on the content of the abstract body. My first thought is it could count if words appear more than once, and, ignoring common words such as the, as, it etc. create keywords based on the top 5-10 words in each abstract body.

###### Creating new journal feeds.

A significant pain point for the application: setting up a new journal feed requires a new method be added to the Adapter class. Given how similar the structure of each journal feed is, I feel like an automated or greatly simplified process is within my abilities. I'd like to explore more journal feeds and their structures before I tackle that though.

One issue with automation is that individual journal feeds structure their abstracts differently. If I simply display the abstracts and their attributes as I receive them, the result is an unsightly mess. Certain abstracts have too many line breaks, others none at all. Some already have html for bold headers and others are simply large blocks of text.

Ultimately the abstracts don't have to look perfect, but their overall formatting should be relatively seamless. Some basic formatting, such as removing line breaks and repetitive headers (such as abstract: or summary:) helps immensely.


### Developer and User stories:
- ~~The User can create custom keywords~~ Completed!
- ~~The User can view abstracts that share a custom keyword~~ Completed!
- The User can search journals by a certain date, or range of dates
- The User can add new journal feeds on their own
- The Application automatically generates keywords if none are available
