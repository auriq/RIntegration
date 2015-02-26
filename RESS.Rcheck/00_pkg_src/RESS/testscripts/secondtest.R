library("RESS")

num <- essQuery("ess task exec \\
", "echo -e \\
'11,12,13\\n4,5,6\\n7,8,9' \\
","\\
#-notitle")

print(num)

num2 <- essQuery("echo -e \\
'11,12,13\\n4,5,6\\n7,8,9' \\
","\\
#-notitle")

print(num2)

num3 <- essQuery("echo -e \\
'11,12,13\\n4,5,6\\n7,8,9' \\
")

print(num3)

