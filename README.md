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

# Evaluate $? with if statement, using (()) and [[]]

```bash
❯ echo "Hello World"
Hello World
❯ if [[ $? ]]; then echo "successfully execution $?"; else echo "execuion failed"; fi
successfully execution 0
❯ echo "Hello World"
Hello World
❯ if (( $? )); then echo "execution failed $?"; else echo "successfull execution $?"; fi
successfull execution 1
```
