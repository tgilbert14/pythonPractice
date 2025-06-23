import tkinter as tk
from tkinter import ttk, messagebox
from PIL import Image, ImageTk


# example, to install use terminal (GitBash) - pip install Pillow


def show_selection():
    team = team_var.get()
    if team == "Select a team":
        logo_label.config(image="")
        logo_label.image = None
        messagebox.showwarning("Oops!", "Please select a valid NBA team.")
    else:
        try:
            # Load and display the logo first
            logo = Image.open(f"logos/{team}.png")
            logo = logo.resize((100, 100))
            logo_img = ImageTk.PhotoImage(logo)
            logo_label.config(image=logo_img, text="")
            logo_label.image = logo_img  # Keep reference
        except FileNotFoundError:
            logo_label.config(text="Logo not found", image="")
            logo_label.image = None

        # Then show the confirmation message
        messagebox.showinfo("Team Selected", f"Your favorite team is: {team}")


# GUI setup
root = tk.Tk()
root.title("Favorite NBA Team")
root.geometry("320x300")

label = tk.Label(root, text="Choose your favorite NBA team:")
label.pack(pady=10)

teams = [
    "Select a team",
    "Los Angeles Lakers", "Golden State Warriors", "Boston Celtics",
    "Phoenix Suns"
]
team_var = tk.StringVar(value=teams[0])
team_dropdown = ttk.Combobox(root, textvariable=team_var, values=teams, state="readonly")
team_dropdown.pack(pady=5)

submit_btn = tk.Button(root, text="Submit", command=show_selection)
submit_btn.pack(pady=10)

# Placeholder for logo image
logo_label = tk.Label(root)
logo_label.pack(pady=10)

root.mainloop()
