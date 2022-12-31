import base64
from uuid import uuid4
import requests
# importing the requests module 

from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP
# importing Cryptography module 
# importing the cryptographic modules 
import pickle
from typing import Union




with open('public_key.pem', 'rb') as file:
    public_key = RSA.import_key(file.read())
    encryptor = PKCS1_OAEP.new(public_key)


url = 'http://127.0.0.1:5500/'

dummyData = {'name':'steev', 'title':'idiot', 'age':69}



def encryptData(data:bytes):
    encrypted =  encryptor.encrypt(data)

    return base64.b64encode(encrypted)


password = "ivanTheGOD"
username = "ivanrj7"
encryptedPassword = encryptData(password.encode())
email = "ivanTHEGOD@gmail.com"

def getImgData(filename:str):
    with open("TestFolder/"+filename, "rb") as file:
        return file.read()

def register():
    response = requests.post(url+'register', data={"email":email,'username':username, 'password':encryptedPassword})
    print(response.status_code, response.text)

def auth():
    response = requests.post(url+'authenticate', params={'username':username, 'password':encryptedPassword})
    print(response.status_code, response.text)

def makePost(title:bytes, annonymous:int, media:Union[None, str, bytes], postType:int):
    data = {'title':title, 'annonymous':annonymous, 'postType':postType, 'nsfw':0, 'spoilers':0}
    
    if media and postType == 1:
        data['media'] = media

    if postType == 1 or postType == 2:
        data['popleList'] = base64.b64encode(pickle.dumps([]))

    if not bool(annonymous):
        data['poster'] = 'ivanTheDestroyerOfIdiots-a03dc093-244a-43e8-81c3-af2ba9adaf36'
        data['location'] = base64.b64encode(pickle.dumps({'lat':32.222435, 'lon':32.222435}))

    if media and postType > 1 and media:
        with open(media, 'rb') as file:
            _file = file.read()
            data['filename'] = media
            response = requests.post(url+'post', data=data, files={'media':_file})
    else:
        response = requests.post(url+'post', data=data)

    print(response.text)

def vote(upvote=True):
    userID = "hkth21aXeAjR"
    postID = "000000xgg9m5"
    if upvote:
        response = requests.post(url+'upvote', data={'isComment':0, 'url':postID, 'userID':userID})
    else:
        response = requests.post(url+'downvote', data={'isComment':0, 'url':postID, 'userID':userID})

    print(response.text)


# register()

# makePost("Dark Knight Rises".encode(), 0, """"It has been eight years since Batman (Christian Bale), in collusion with Commissioner Gordon (Gary Oldman), vanished into the night. Assuming responsibility for the death of Harvey Dent, Batman sacrificed everything for what he and Gordon hoped would be the greater good. However, the arrival of a cunning cat burglar (Anne Hathaway) and a merciless terrorist named Bane (Tom Hardy) force Batman out of exile and into a battle he may not be able to win.""", 1)

if __name__ == "__main__":
    vote()


