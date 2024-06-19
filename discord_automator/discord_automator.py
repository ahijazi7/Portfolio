import time
import random
import threading
from pywinauto import Application

# Project to automate commands of a widely known "Owo Bot" on the Discord App


running = True
paused = threading.Event()
message_count = 0


def bring_discord_to_foreground():
    try:
        app = Application(backend="uia").connect(title_re=".*Discord.*")
        discord_window = app.top_window()
        discord_window.set_focus()
        return discord_window
    except Exception as e:
        print(f"Error bringing Discord to foreground: {e}")
        return None


def send_message():
    try:
        discord_window = bring_discord_to_foreground()
        if (discord_window is None):
            return

        # Send messages
        discord_window.type_keys('owo h{ENTER}', with_spaces=True)
        time.sleep(random.uniform(1.7, 3.2))
        discord_window.type_keys('owo b{ENTER}', with_spaces=True)
    except Exception as e:
        print(f"Error sending message: {e}")


def bot_loop():
    global message_count
    while running:
        paused.wait()  # Wait here if paused is set
        send_message()
        message_count += 1

        # Pause for one minute every four minutes
        if message_count >= 8:  # Assuming about 30 seconds per message including wait time
            print("Taking a 1-minute break...")
            time.sleep(60)
            message_count = 0

        wait_time = random.uniform(21, 25)
        print(f"Next message in {wait_time:.1f} seconds")
        for i in range(int(wait_time * 10)):
            if not running:
                break
            time.sleep(0.1)


# Function to pause the bot
def pause_bot():
    paused.clear()
    print("Bot paused...")


# Function to resume the bot
def resume_bot():
    paused.set()
    print("Bot resumed...")


# Initialize paused to True
paused.set()

# Start the bot in a separate thread
bot_thread = threading.Thread(target=bot_loop)
bot_thread.start()

# Control loop to handle pausing and resuming the bot
try:
    while True:
        command = input("Enter 'p' to pause, 'r' to resume: ").strip().lower()
        if command == "p":
            pause_bot()
        elif command == "r":
            resume_bot()
except KeyboardInterrupt:
    pass

# Ensure the bot stops and closes any resources if the script is interrupted
running = False
bot_thread.join()
