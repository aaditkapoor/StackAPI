# StackAPI
A unofficial StackOverFlow API to get the required answer for a topic. The Framework works using the StackOverFlow API to get the urls of the questions and then uses Kanna (Web Scraping (xpath)) to scrap the first answer from the url.
# Example
```swift
let api = StackOverFlowAnswerAPI(query: "swift")
api.getPossibleQuestions { (data) in
    for d in data {
        print(d.title,d.url) // Tht title of the question related to Swift and its URL.
        
        var scraper = Scraper(forUrl: d.url)
        scraper.scrape(completion: { (title, answer) in
            print(title, answer) // The title of the question and the its answer.
        })
    }
}
```
# Installation
Install using Cocoapods
```
    pod 'StackAPI'
```
# Contact:Email
Email: aaditkapoor2000@gmail.com
# Contact:Facebook
Facebook: www.facebook.com/aadit.kapoor71
