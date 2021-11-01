
# Python program to add two binary numbers.

# Driver code
# Declaring the variables
#a = "1101"
#b = "100"
a, b = [int(x) for x in input("Enter two values\n").split(', ')]
print("\nThe value of a is {} and b is {}".format(a, b))
# Calculating binary value using function
print(type(a))
sum = bin(int(str(a), 2) + int(str(b), 2))

# Printing result
print(sum[2:])