from randomID import generateid
from idcheck import idcheck
from experiment import videostats

idlist = []

while len(idlist) != 1: #brute force video id generation
    generated = idcheck(generateid(11, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_'))
    print(generated)
    if generated == 1:
        idlist.append()
        print("Yes")
print(idlist)

generatedchannel = generateid(22, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_')

for _ in range(12): #brute force channel id generation
    generatedchannel = generateid(22, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_')
    print('UC' + generatedchannel)