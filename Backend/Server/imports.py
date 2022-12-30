import base64
from urllib import response
from flask import Flask
from flask import request
from flask import json
# importing flask modules 

from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP
# importing Cryptography module 

import uuid
# importing the uuid module 

from pymongo.mongo_client import MongoClient
# importing mongoclient 

from funcs import *
# importing custom functions

import time
# importing time module 

import pickle
# for decoding lists and stuff 

import logging
# logging for werkzeug 

from keyWord import getKeyWords
# keyword finder function 

import asyncio
# for async coding  

from PIL import Image

import asyncio



mongo = MongoClient("mongodb://localhost:27017")
dataBase = mongo['Skol']
userData = mongo['userData']
userBase = dataBase['userBase']
posts = dataBase['posts']
# getting all the databases and the mongo db documents 


# ---------------------------------------- IMPORTING MODULES ----------------------------------------




with open('private_key.pem', 'rb') as file:
    private_key = RSA.import_key(file.read())
    
with open("../../FrontEnd/skoltakesw/assets/host.txt") as hostFile:
    URL = hostFile.read()
    print(f"[HOST] Running the server on {URL}")
    PORT = 5500
    # setting the port and url 


# ---------------------------------------- IMPORTING FILES ----------------------------------------

