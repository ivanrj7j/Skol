from random import shuffle
from imports import *
# importing all the import files 



app = Flask(__name__)
# initialising the application 

LOGCONSOLE = True
# change this to false when going to production 

if not LOGCONSOLE:
    """
    Disabling console logging of each requests when going to production 
    """
    log = logging.getLogger('werkzeug')
    log.setLevel(logging.ERROR)



@app.route('/')
def home():
    """
    Main Page, Currently does nothing.
    """
    return "Ohio!"

@app.route('/register', methods=['POST'])
def register():
    """
    Authenticates the sign up requests and registers a new user to the database.
    """
    data = request.form
    username = data.get('username')
    id_ = getUUID(posts, userBase)
    password = data.get('password')
    email = data.get('email')
    # getting id, username and password 
    
    if userBase.find_one({'username':username}) or userBase.find_one({'email':email}):
        return app.response_class(b'The username/email is already taken', 418)
        # exiting the process if the username is taken 
    else:
        userBase.insert_one({'email': email ,'username':username, 'password':password, 'id':id_})
        # inserting the user into the user's list
         
        userData[id_].insert_one({'type':'id', 'id':id_})
        userData[id_].insert_one({'type':'username','username':username})
        userData[id_].insert_one({'type':'email','email':email})
        # inserting the data to user's private database 
        
        return app.response_class(json.dumps({"userID":id_, "username":username, "email":email}), 200)


@app.route('/authenticate', methods=['POST'])
def authenticate():
    data = request.form
    username = data.get('username')
    password = decrypt(data.get('password'), private_key)
    # getting username and password 

    if username.__contains__("@"):
        user = userBase.find_one({'email':username})
    else:
        user = userBase.find_one({'username':username})
    # getting the user's data from the database 

    if not user:
        """
        returning an error if the user is not found
        """ 
        return app.response_class(b'No user found', 404)
    
  
    if user and decrypt(user['password'], private_key) == password:
        """
        Sending the user's email, username and id if the login was a success
        """
        return app.response_class(json.dumps({"userID":user['id'], "username":username, "email":user["email"]}), 200)
    else:
        """
        Sending a wrong password response if the password was wrong
        """
        return app.response_class(b'Wrong Password', 406)

@app.route('/post', methods=['POST'])
def post():
    """Inserts a Post to the database
    
    postType(s):
        1 = Text
        2 = Image
        3 = Video
    """
    

    data = request.form
    title = data.get('title') or ""
    annonymous = bool(int(data.get('annonymous')))
    nsfw = bool(int(data.get('nsfw')))
    spoilers = bool(int(data.get('spoilers')))
    postType = int(data.get('postType'))
    timeOfPost = time.time()
    points = 0
    urlEndPoint = getUUID(posts, userBase)
    # getting the data about the post 

    
    postData = {'title':title, 'annonymous':annonymous, 'postType':postType, 'timeOfPost':timeOfPost, 'points':points, 'urlEndPoint':urlEndPoint, 'nsfw':nsfw, 'spoilers':spoilers}
    # preparing the data to post to the db
    
    if not annonymous:
        """including the id of the poster and the location of the post if it is not annonymous """
        poster = data.get('user')
        if not userBase.find_one({'id':poster}):
            return app.response_class(b'User not found', 404)
            # returning an error if the userid was not found and aborting the post 

        postData['user'] = poster
        postData['location'] = pickle.loads(base64.b64decode(data.get('location')))
    
    if not annonymous and postType == 3 or postType == 2:
        """including the list of people if the post is an image or video and if the post is not annonymous"""
        postData['people'] = pickle.loads(base64.b64decode(data.get('popleList')))


    if 'user' in postData:
        """inserting the url of the post to the user's feed """
        userData[postData['user']].insert_one({'type':'post', 'Post': postData['urlEndPoint']})

    if postType == 3 or postType==2:
        """saving the file if the media is an image or video """
        mediaFile = request.files.get('media')
        newFilename = urlEndPoint +"."+ data.get('filename').split('.')[-1]
        # getting the file and creating a new file name 

        if postType == 2:
            asyncio.run(compressImage(mediaFile, newFilename, (nsfw or spoilers)))
            # compressing the media if its an image

        postData['media'] = newFilename
        # setting the filename 


        if postType == 2:
            image = Image.open(mediaFile)
            image.save("Static/Media/"+newFilename)
        else:
            mediaFile.save("Static/Media/"+newFilename)
        # saving the file 

    else:
        """setting the media as the text if the post is not an image or a video """
        postData['media'] = data.get('media')


    posts.insert_one(postData)
    # inserting the post to the database 

    asyncio.run(getKeyWords(urlEndPoint))
    # extracting the keywords
    
    return 'Posted!'

@app.route('/getPosts', methods=['POST'])
def getPosts():
    """
    Returns posts for user to scroll through        
    """

    data = request.form
    user = data.get('userID')
    noOfPosts = int(data.get('noOfPosts'))

    posts = fetchPosts(noOfPosts)
    returnData = []
    for post in posts:
        postData = {}
        
        postData['name'] = '@'+post['user'][:12]
        postData['username'] = 'communityName'


        postData['postType'] = post['postType']
        postData['pfp'] = 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Favatarfiles.alphacoders.com%2F108%2Fthumb-108917.png&f=1&nofb=1&ipt=328954ed74700ec81593974238dcdebfa03b79c13d50a306028dc758ac5021be&ipo=images'
        postData['caption'] = post['title']
        if post['postType'] > 1:
            postData['media'] = post['media']
            postData['filename'] = URL+"/static/Previews/"+post['urlEndPoint']+'.'+post['extension'] if post['extension'].lower() in ['png', 'jpg', 'jpeg'] else URL+"/static/Media/"+post['urlEndPoint']+'.'+post['extension']
        else:
            postData['media'] = post['media']
        postData['url'] = URL+"/"+post['urlEndPoint']
        postData['points'] = post['points']
        postData['comments'] = round(post['points']*(randint(80, 530)/100))
        returnData.append(postData)

    

    return returnData
    

@app.route('/upvote', methods=['POST'])
def upvotePost():
    try:
        data = request.form
        url = data.get('url')
        isComment = bool(int(data.get('isComment')))
        upvoter = data.get('userID')
        # getting the request data 

        if not userData[upvoter].find_one({'type':'upvote', 'urlEndPoint':url}):
            # checking if the user has already upvoted the post 
            if isComment:
                pass
                # TODO: if the post is a comment
            else:
                posts.find_one_and_update({'urlEndPoint': url}, {'$inc':{'points':1}})
                # giving the vote 

            userData[upvoter].insert_one({'type':'upvote', 'urlEndPoint':url})
            # registering the vote 

            if userData[upvoter].find_one({'type':'downvote', 'urlEndPoint':url}):
                userData[upvoter].find_one_and_delete({'type':'downvote', 'urlEndPoint':url})
                # if the user has already upvoted, deleting that vote 
            return "Voted!"
        else:
            return "Already Voted"
    except:
        return app.response_class('Something went wrong', 400)

@app.route('/downvote', methods=['POST'])
def downvotePost():
    try:
        data = request.form
        url = data.get('url')
        isComment = bool(int(data.get('isComment')))
        downvoter = data.get('userID')
        # getting the request data 

        if not userData[downvoter].find_one({'type':'downvote', 'urlEndPoint':url}):
            # checking if the user has already upvoted the post 
            if isComment:
                pass
                # TODO: if the post is a comment
            else:
                posts.find_one_and_update({'urlEndPoint': url}, {'$inc':{'points':-1}})
                # giving the vote 

            userData[downvoter].insert_one({'type':'downvote', 'urlEndPoint':url})
            # registering the vote 

            if userData[downvoter].find_one({'type':'upvote', 'urlEndPoint':url}):
                userData[downvoter].find_one_and_delete({'type':'upvote', 'urlEndPoint':url})
                # if the user has already downvoted, deleting that vote 
            return "Voted!"
        else:
            return "Already Voted"
    except:
        return app.response_class('Something went wrong', 400)

def fetchPosts(noOfPosts):
    """
    fetches the posts for the user
    
    The method used here for fetching posts are just a prototype for now, it will be updated in the future.

    Ideas:
        Prefind the posts for user to scroll through beforehand and give it to them later for ten minutes
        or so to save processing time.
    """ 
    returnData = list(posts.find({}))
    shuffle(returnData)
    for data in returnData:
        data.pop("_id")
        data["host"] = URL
    if len(returnData) > noOfPosts:
        return returnData[:noOfPosts]
    
    return returnData


def getUserInfo(userID:str):
    user = userBase.find_one({'id':userID})
    if user and 'name' in user and 'id' in user:
        return (user['name'], user['id'])
    else:
        return ('None', 'None')
    

if __name__ == '__main__':
    app.run(debug=True, port=PORT)