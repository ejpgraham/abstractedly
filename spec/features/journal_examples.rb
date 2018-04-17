module JournalExamples
test_journals = JournalFeed.create!([
{title: "Journal of Nuclear Medicine", url:"http://jnm.snmjournals.org/rss/current.xml"},
{title: "European Journal of Nuclear Medicine and Imaging", url:
"https://link.springer.com/search.rss?facet-content-type=Article&facet-journal-id=259&channel-name=European+Journal+of+Nuclear+Medicine+and+Molecular+Imaging"},
{title: "NeuroImage", url: "http://rss.sciencedirect.com/publication/science/10538119"},
{title: "Science Translational Medicine", url: "http://stm.sciencemag.org/rss/current.xml"},
{title: "Nuclear Medicine and Biology", url: "http://rss.sciencedirect.com/publication/science/09698051"},
{title: "Cell", url: "http://www.cell.com/cell/current.rss"},
{title: "Science", url: "http://science.sciencemag.org/rss/express.xml"},
{title: "Biochimica et Biophysica Acta", url: "http://rss.sciencedirect.com/publication/science/03044165"},
{title: "Journal of Biochemistry", url: "https://academic.oup.com/rss/site_5303/3169.xml"},
{title: "E Life Sciences", url: "https://medium.com/feed/@eLife"},
{title: "The Prostate", url: "http://onlinelibrary.wiley.com/rss/journal/10.1002/(ISSN)1097-0045"},
{title: "Royal Society of Chemistry: Chemical Science", url: "http://feeds.rsc.org/rss/sc"},
{title: "asdfasdfa", url: "asdfasdfasdfasdf"},
{title: "crystals", url: "http://feeds.rsc.org/rss/ce"},
{title: "Green Chemistry", url: "http://feeds.rsc.org/rss/gc"},
{title: "hello", url: "buttface"},
{title: "Journal of Material Chemistry A", url: "http://feeds.rsc.org/rss/ta"}
])
end
