a = -8.00439
b = -21.988
# a = 0.00438564
# b = -0.0120473
A = 4
B = 0
C = 1
D = -4
E = -1
F = -11
f = 0.1
print(A+E*a*a/f+2*D*a/f)
print(C+E*b*b/f+2*F*b/f)
print(E*a/f+D/f)
print(E*b/f+F/f)
print(E/f)

r = 0.030975
q = (2*E*a*r+2*D*r)/(A*f+E*a*a+2*D*a)
l = (2*E*b*r+2*F*r)/(A*f+E*a*a+2*D*a)
p = (-E*r*r)/(A*f+E*a*a+2*D*a)
print(q)
print(l)
print(p)