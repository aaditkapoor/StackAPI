/**

 Example
 =========================================
 
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
*/


