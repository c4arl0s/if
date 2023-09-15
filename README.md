# Snippets for if-sentence

# if-else

```bash
if echo "hello" && echo "World"; then echo "OK"; fi
```

```console
hello
World
OK
```

# Evaluate $? with if statement, using if [[ ]] and if (( ))

```bash
❯ echo "Hello World"
Hello World
❯ if [[ $? ]]; then echo "successful execution $?"; else echo "execution failed"; fi
successful execution 0
```

```bash
❯ echo "Hello World"
Hello World
❯ if (( $? )); then echo "execution failed $?"; else echo "successfull execution, but \$? = $?"; fi
successfull execution, but $? = 1
```

# Evaluate using if [ ]

```bash
if [ $# -lt 3 ]
then
    printf "%b" "Error. Not enough arguments.\n"
    printf "%b" "usage: myscript file1 op file2\n"
    # exit 1 # uncomment on a script
fi
```

Alternatively

```bash
if (( $# < 3 ))
then
    printf "%b" "Error. Not enough arguments.\n"
    printf "%b" "usage: myscript file1 op file2\n"
    # exit 1 # uncomment on a script
fi
```

# Using if (( )) and elif statement

```bash
if (( $# < 3 ))
then
    printf "%b" "Error. Not enough arguments.\n"
    printf "%b" "usage: myscript file1 op file2\n"
    # exit 1 # uncomment on a script
elif (( $# > 3 ))
then
    printf "%b" "Error. Too many arguments.\n"
    printf "%b" "usage: myscript file1 op file2\n"
    # exit 2 # uncomment on a script
else
    printf "%b" "Argument count correct.  Proceeding...\n"
fi
```

# Comparing strings inside if statement

```bash
choice="yes"
if [ "$choice" = "yes" ]; then
    echo "Your choice is yes"
fi
```

Output:

```console
Your choice is yes
```

# Using only [ ]

```bash
result=1
[ $result = 1 ] && { echo "Result is 1" }
Result is 1
```

# Using if and test (then you can omit [ ])

```bash
if test $# -lt 3
then
    echo try again.
fi
```

Output

```bash
try again
```

# Use a command as sentence of if

```bash
mkdir directory
if [ $? = 0 ]; then
    echo "directory was created successfully"
else 
    echo "directory was already created"
fi
```

move the command into the if statement

```bash

if mkdir directory; then
    echo "directory was created successfully"
else 
    echo "directory was already created"
fi
```

