# pip install python-telegram-bot==13.11
from datetime import datetime

from telegram.ext import Updater, Filters, CommandHandler, CallbackContext
from telegram.ext import MessageHandler
import os
API_KEY ="6144699768:AAFFT4z4Z99PH0507xswi8gCSvWxEJ6Jrtg"
updater = Updater(token=API_KEY, use_context=True)

def fn_save_photo(update, context:CallbackContext): #메세지에서 온 파일 경로가 들어오면 거기다가 이미지를 저장하게해준다.
    img_dir = './img/'
    if not os.path.exists(img_dir):
        os.mkdir(img_dir)
    current = datetime.now()
    str_date = current.strftime('%Y%m%d%H%M%S') #년월일시분초
    file_path = os.path.join(img_dir,str_date +'.png')
    bot = context.bot
    photo = bot.getFile(update.message.photo[-1].file_id)
    photo.download(file_path)
    update.message.reply_text('photo save')

def echo(update, context):
    user_id = update.effective_chat.id
    user_text = update.message.text
    context.bot.send_message(chat_id=user_id, text=user_text)
    
def fn_diary(update, context):
    user_id = update.effective_chat.id
    user_text = update.message.text
    if '종료' in user_text:
        context.bot.send_message(chat_id = user_id, text="다이어리종료")
    else:
        print("메모 쓰는 기능")
        f = open('diary.txt', 'a')
        msg = user_text.replace('/d', '').strip()
        f.write(msg)
        f.writelines('\n')
        f.close()
        context.bot.send_message(chat_id = user_id, text="내용을 추가함")

echo_handler = MessageHandler(Filters.text & (~Filters.command), echo) #메세지가 왔을때 핸들러가 작동한다(메세지가 왔을때 echo 함수가 작동하게)
updater.dispatcher.add_handler(echo_handler) #(해당이벤트가 일어나면 작동하게 해줌)

diary_handler = CommandHandler('d', fn_diary) #/d로 하면 함수가 작동하게한다.
updater.dispatcher.add_handler(diary_handler)


photo_handler = MessageHandler(Filters.photo, fn_save_photo)
updater.dispatcher.add_handler(photo_handler)

updater.start_polling() #시작
updater.idle()