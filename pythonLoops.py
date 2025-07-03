word = "secret"
vowels = ["a", "e", "i", "o", "u"]
vowel_count = 0
# for loops
for letter in word:
    if letter in vowels:
        vowel_count += 1
print(f"there are {vowel_count} vowels in '{word}'")

# range(start=0, stop, step=1)
print("range example")

for i in range(4):
    print(i)

# print("range odd numbers")
# odd numbers
# for i in range(1, 8, 2):
#    print(i)

# print("vowels")
# for v in vowels:
#    print(v)

print("while loop - vowels")
# while loops
i = 0
while i < len(vowels):
    print(vowels[i])
    i = i + 1

# calling function inside own function
print("recursive functions")


# example of getting factorial, product of all positive integers (n!) <= n
# n! = n(n-2)(n-2) ... 1
# (n-1)! = (n-1)(n-2) ... 1
# factorial ex.. 1!=1, 2!=2*1=2, 3!=3*2*1=6, etc.

def factorial(n: int):
    """Return the factorial positive integer n."""
    # 1 is base case and simple to calculate
    if n == 1:
        return 1
    else:
        # above 1 it is more complex
        return n * factorial(n - 1)


print(factorial(7))


# take positive int and return the sum of digits in n
# e.g., sum of 5 is 5, sum of 25 is 7 (2+5), etc...
# sum of 1st digit plus 2nd digit, etc... last digit
# or sum of last digit plus next, etc...

def sum_digits(n: int, depth=0):
    indent = "  " * depth  # For visual indentation

    if n < 10:
        # single digit
        print(f"{indent}Returning {n} (base case)")
        return n
    else:
        # more than 2 digits - gets rid of last digit (no decimal "//")
        all_but_last = n // 10
        # gets the last digit
        last = n % 10
        print(f"{indent}Breaking down {n} → {all_but_last} + {last}")
        result = sum_digits(all_but_last, depth + 1) + last
        return result


print(sum_digits(2505))


# recursive string function..
def reverse_string(s: str):
    if len(s) <= 1:
        return f"{s} "
    else:
        # new letter from pos 1 and beyond + first letter in pos 0
        return reverse_string(s[1:]) + f"{s[0]} "


print(reverse_string("abcdefg"))


# palindromes
def is_palindrome(str2: str):
    # one char means it is!
    if len(str2) <= 0:
        return True
    else:
        # checks if 1st and last char match and if the remaining string match
        print(str2[1:-1])
        return str2[0] == str2[-1] and is_palindrome(str2[1:-1])


print(is_palindrome("racecar"))
