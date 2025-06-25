# OOP
class Dog():
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def bark(self):
        print(self.name, "is barking!")

    def addYear(self):
        self.age += 1

    def getInfo(self):
        print(self.name, "is", self.age, "years old.")


fido = Dog("Fido", 2)
fido.bark()

print(fido.name)
print(fido.age)


# new class of 'Dog' can inherit
class Husky(Dog):
    def __init__(self, name, age, color="unknown", weight="unknown"):
        super().__init__(name, age)
        self.color = color
        self.weight = weight

    def bark(self, manner="energetically"):
        print(f"{self.name} is barking {manner}.")

    def getInfo(self):
        print(f"{self.name} is a {self.age} years old {self.color} Husky and weighs {self.weight} pounds")


class Corgi(Dog):
    def __init__(self, name, age, color="unknown", weight="unknown"):
        super().__init__(name, age)
        self.color = color
        self.weight = weight

    def bark(self, manner="briefly"):
        print(f"{self.name} is barking {manner}.")

    def getInfo(self):
        print(f"{self.name} is a {self.age} years old {self.color} Corgi and weighs {self.weight} pounds")


ella = Dog("Ella", 3.5)

ella.getInfo()
ella.bark()
ella.addYear()
ella.getInfo()

ella2 = Husky("Ella2", 3.5, "?", 75)
ella2.bark()
ella2.getInfo()

june = Corgi("June", 6, "white")
june.bark()
june.getInfo()
