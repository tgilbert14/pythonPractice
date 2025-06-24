# if else section - python part 2

# n = input("enter a number: ")

# n = int(n)
# print(type(n))

# if n < 5:
#    print(f"Int {n} is less than 5")


def minimum(x, y):
    if x < y:
        return x
    else:
        return y


result = minimum(34, 55)
result2 = minimum(56, 33)
print(result)
print(result2)

import tkinter as tk
from tkinter import ttk

# GUI setup
root = tk.Tk()
root.title("Favorite NBA Team")
root.geometry("320x300")


label = tk.Label(root, text="Choose your favorite NBA team:")
label.pack(pady=10)
textbox = tk.Text(root)
#textbox.place()

teams = [
    "Select a team",
    "Los Angeles Lakers", "Golden State Warriors", "Boston Celtics",
    "Phoenix Suns"
]
team_var = tk.StringVar(value=teams[0])
team_dropdown = ttk.Combobox(root, textvariable=team_var, values=teams, state="readonly")
team_dropdown.pack(pady=5)


#submit_btn = tk.Button(root, text="Submit", command=show_selection)
#submit_btn.pack(pady=10)

# Placeholder for logo image
logo_label = tk.Label(root)
logo_label.pack(pady=10)

root.mainloop()