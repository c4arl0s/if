# Snippets for if-sentence

1. [if-else]()
2. [Evaluate `$?` with `if` statement, using `if [[ ]]` and `if (( ))`]()
3. [Evaluate using `if [ ]`]()
4. [Using `if (( ))` and elif statement]()
5. [Comparing strings inside `if` statement]()
6. [Using only `[ ]`]()
7. [Using `if` and `test` (then you can omit `[ ]`)]()
8. [Use a command as sentence of `if`]()
9. [Use double square bracket `[[ ]]` to test strings]()
10. [Use `test` inside and `if` statement]()
11. [Equivalence using `if-else` statement and `command && command || command`]()
12. [Multiple conditions on if statement]()

# 1. if-else

```bash
if echo "hello" && echo "World"; then echo "OK"; fi
```

```console
hello
World
OK
```

# 2. Evaluate `$?` with `if` statement, using `if [[ ]]` and `if (( ))`

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

# 3. Evaluate using `if [ ]`

```bash
if [ $# -lt 3 ]; then
  printf "%b" "Error. Not enough arguments.\n"
  printf "%b" "usage: myscript file1 op file2\n"
  # exit 1 # uncomment on a script
fi
```

Alternatively

```bash
if (( $# < 3 )); then
  printf "%b" "Error. Not enough arguments.\n"
  printf "%b" "usage: myscript file1 op file2\n"
  # exit 1 # uncomment on a script
fi
```

# 4. Using `if (( ))` and elif statement

```bash
if (( $# < 3 )); then
  printf "%b" "Error. Not enough arguments.\n"
  printf "%b" "usage: myscript file1 op file2\n"
  # exit 1 # uncomment on a script
elif (( $# > 3 )); then
  printf "%b" "Error. Too many arguments.\n"
  printf "%b" "usage: myscript file1 op file2\n"
  # exit 2 # uncomment on a script
else
  printf "%b" "Argument count correct.  Proceeding...\n"
fi
```

# 5. Comparing strings inside `if` statement

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

# 6. Using only `[ ]`

```bash
result=1
[ $result = 1 ] && { echo "Result is 1" }
Result is 1
```

# 7. Using `if` and `test` (then you can omit `[ ]`)

```bash
if test $# -lt 3; then
  echo try again.
fi
```

Output

```bash
try again
```

# 8. Use a command as sentence of `if`

```bash
mkdir directory
if [ $? = 0 ]; then
  echo "directory was created successfully"
else 
  echo "directory was already created"
fi
```

move the command into the `if` statement

```bash
if mkdir directory; then
  echo "directory was created successfully"
else 
  echo "directory was already created"
fi
```

# 9. Use double square bracket `[[ ]]` to test strings

```bash
if [[ "${var}" == "some_string" ]]; then
  echo "do something"
fi
```

```bash
# -z (string length is zero) and -n (string length is not zero) are
# preferred over testing for an empty string
if [[ -z "${my_var}" ]]; then
  echo "do something"
fi
```

```bash
# This is OK (ensure quotes on the empty side), but not preferred:
if [[ "${my_var}" == "" ]]; then
  echo "do something"
fi
```

# 10. Use `test` inside and `if` statement

```bash
touch ~/file.txt
if test -f ~/file.txt; then
  echo "file exist"
else 
  echo "file does not exist"
fi
```

console output

```console
file exist"
```

# 11. Equivalence using `if-else` statement and `command && command || command`

```bash
if cp file.txt $HOME/iOS-Projects; then
  echo "Done"
else 
  echo "failed"
  exit 1
fi
```

Equivalence:

```bash
cp file.txt $HOME/iOS-Projects && { echo "Done" } || { echo "Failed"; exit 1 }
```

> In this case we should use the exit command in order to point out that the command was not successfully executed" 

# 12. Multiple conditions on if statement

```bash
#!/bin/bash

var_one=1

# Only one var might be set
var_two=
var_three=1

# Only one flag might be set
flag_one=
flag_two=
flag_three=

# draw table of thruth

if [[ "${var_one}" ]] && { [[ "${var_two}" ]] || [[ "${var_three}" ]]; } && { [[ -z "${flag_one}" ]] && [[ -z "${flag_two}" ]] && [[ -z "${flag_three}" ]]; }; then
  echo "flag_one=$flag_one"
  echo "flag_two=$flag_two"
  echo "flag_three=$flag_three"
  echo "all flags are length zero"
  exit 1
fi
```

```console
./if-statement.sh
```

Console output:

```console
flag_one=
flag_two=
flag_three=
all flags are length zero
```
