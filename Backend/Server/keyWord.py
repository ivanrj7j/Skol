import yake
# importing yake 

from pymongo.mongo_client import MongoClient
# importing mongoclient 

mongo = MongoClient("mongodb://localhost:27017")
dataBase = mongo['Skol']
posts = dataBase['posts']
userData = mongo['userData']
words = dataBase['words']


async def getKeyWords(url:str):
    """
    Extracts keywords from the given text and posts to the database.

    """
    postData = dict(posts.find_one({'urlEndPoint':url}))
    # getting the post's data 

    kw_extractor = yake.KeywordExtractor(top=25, stopwords=None)
    # initialising the extractor 

    
    if postData['postType'] == 1:
        keywords = kw_extractor.extract_keywords(postData['title'].lower()+ " " + postData['media'].lower())
        final_keywords = {kw: v for kw,v in keywords}
        insertKeyWord([kw for kw,v in keywords])
        # getting the keywords from the title and media 
    else:
        keywords = kw_extractor.extract_keywords(postData['title'].lower())
        final_keywords = {kw: v for kw,v in keywords}
        insertKeyWord([kw for kw,v in keywords])
        # getting the keywords from the title 
        

    posts.find_one_and_update({'urlEndPoint':url}, {'$set':{'keywords':final_keywords}})
    # -------------updating the keywords in the post-------------

    if not postData['annonymous']:
        """
        Updating the user's intersts if the post is not annonymous
        """
        poster = postData['poster']
        userDB = userData[poster]
        # getting the poster's database 

        interestsDocument = userDB.find_one({'type':'interests'})
        # user's interests

        if not interestsDocument:
            final_keywords = {key:val for key, val in final_keywords.items() if val >= 0.07}
            userDB.insert_one({'type':'interests','interests':final_keywords})
            # creating a new user interests document if it does not exists 

        else:
            userIntersts = dict(dict(interestsDocument)['interests'])
            # getting the user's interests

            for interest in final_keywords:
                if interest in userIntersts and final_keywords[interest] >= 0.07:
                    userIntersts[interest] += final_keywords[interest]
                    # adding the interests value to the existing interest if the value is greater that 0.07

                else:
                    if final_keywords[interest] >= 0.07:
                        userIntersts[interest] = final_keywords[interest]
                    # setting a new interest if the value is greater that 0.07

            userDB.find_one_and_update({"type":"interests"}, {'$set':{'interests':userIntersts}})
    
    
    # -------------updating the keywords in the user's intersts-------------


def insertKeyWord(keywords:list):
    currentKeyWords = list(words.find_one()['words'])
    for keyword in keywords:
        if keyword not in currentKeyWords:
            currentKeyWords.append(keyword)

    words.find_one_and_update(filter={}, update={'$set':{'words':currentKeyWords}})