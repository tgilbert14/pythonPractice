# python basics - python part 1

import calendar
import math
import random


cal = calendar.month(2025, 6)
# print(cal)


def greet():
    name = input("Name?: ").strip()
    time = input("am or pm?: ").strip().lower()

    if not name:
        print("Missing name! Try entering at least one character.")
    elif time not in ["am", "pm"]:
        print("Time must be either 'am' or 'pm'. Please try again.")
    else:
        print(f"Hi {name}, meet @7{time}.")
# greet()


# random choice
color = ["blue", "green", "red", "yellow"]
pick = random.choice(color)
print(pick)


# random shuffle
print(color)
random.shuffle(color)
print("After shuffle...")
print(color)
print(type(color))


# math
print(math.pow(2, 2))
print(math.sqrt(49))

# lists - stored in "[]"
print("listA is...")
listA = ["a", "b", "c"]
print(listA)
print(f"Index position 2 on listA is '{listA[2]}'")
# these can be changed or updated
listA[2] = "C"
print(listA)


# tuples can be used for specific order - stored in "()" - cannot be changed!
child1_birth = ("Julia", "Banner Hospital", "Tucson", "AZ", "USA", "07-29-2019", "09:42")
child2_birth = ("SnoopDog", "Portland Hospital", "Portland", "OR", "USA", "03-15-1978", "12:47")
print(f"{child1_birth[0]} was born on {child1_birth[5]} in {child1_birth[2]}, {child1_birth[3]}")
print(f"{child2_birth[0]} was born on {child2_birth[5]} in {child2_birth[2]}, {child2_birth[3]}")


# quit ##this is for coding in R studio to quit python env
