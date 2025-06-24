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
from tkinter import ttk, messagebox

def show_selection():
    print(f"Team selected: {team_var.get()}")
    print(f"Notes: {textbox.get('1.0', 'end').strip()}")
    # Then show the confirmation message
    messagebox.showinfo(
        "Team Selected!",
        f"Team: {team_var.get()}\nNotes: {textbox.get('1.0', 'end').strip()}"
    )

root = tk.Tk()
root.title("Grid Layout Example")
root.geometry("400x200")

# Dropdown label and widget
tk.Label(root, text="Choose your favorite team:").grid(row=0, column=0, padx=10, pady=10, sticky="w")

teams = ["Lakers", "Warriors", "Celtics", "Suns"]
team_var = tk.StringVar(value=teams[0])
team_dropdown = ttk.Combobox(root, textvariable=team_var, values=teams, state="readonly")
team_dropdown.grid(row=0, column=1, padx=10, pady=10)

# Text box label and widget
tk.Label(root, text="Why you like them?").grid(row=1, column=0, padx=10, pady=10, sticky="nw")

textbox = tk.Text(root, height=4, width=30)
textbox.grid(row=1, column=1, padx=10, pady=10)

# Submit button
submit_btn = tk.Button(root, text="Submit", command=show_selection)
submit_btn.grid(row=2, column=0, columnspan=2, pady=10)

root.mainloop()