from PIL import Image
from PIL import ImageFilter
import base64
from Crypto.Cipher import PKCS1_OAEP
from random import randint
# importing the modules 


def getUUID(posts, userBase, length=12):
    """
    generates a random base-64 11-digit uuid
    """
    characters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM0123456789+-"
    newURL = "".join([characters[randint(0, len(characters)-1)] for i in range(length)])

    if not posts.find_one({'urlEndPoint':newURL}) and not userBase.find_one({"id":newURL}):
        return newURL
    else:
        getUUID(length=length)
    

def decrypt(encrypted:bytes, private_key):
    """
    Decrypts the given bytes using PKCS1_OAEP algorythm
    """
    decryptor = PKCS1_OAEP.new(private_key)
    encrypted = base64.b64decode(encrypted)
    return decryptor.decrypt(encrypted)

async def compressImage(image, filename:str, blur:bool):
    """
    Compresses an image for quick previews 
    """
    image = Image.open(image)
    if min(image.width, image.height) > 720:
        if image.width > image.height:
            newHeight = 720
            newWidth = int(image.width * (newHeight/image.height))
            # setting the size of the new Image without losing the ratio

            image = image.resize((newWidth, newHeight))
            # downscaling the image if the image is more than 720p
        else:
            newWidth = 720
            newHeight = int(image.height * (newWidth/image.width))

            image = image.resize((newWidth, newHeight))
            # downscaling the image if the image is more than 720p
    else:
        newHeight = image.height
        newWidth = image.width
        # setting the size as the same if the image is less that 720p

    croppedWidth, croppedHeight = (newWidth, newWidth*(9/16))
    # if newWidth > newHeight:
    #     croppedWidth, croppedHeight = (newWidth*(16/9), newWidth)


    left = (newWidth - croppedWidth)/2
    top = (newHeight - croppedHeight)/2
    right = (newWidth + croppedWidth)/2
    bottom = (newHeight + croppedHeight)/2

    image = image.crop((left, top, right, bottom))
    # cropping the image 

    if blur:
        """blurring the image if it's nsfw or spoiler"""
        image = image.filter(ImageFilter.GaussianBlur(40))


    if filename.split()[-1].lower() in ['jpg', 'png', 'jpeg']:
        image.save("Static/Previews/"+filename, optimize=True, quality=80)   
        # optimising the image if and lowering the quality if supported 
    else:
        image.save("Static/Previews/"+filename)   
    # saving the image 
    

