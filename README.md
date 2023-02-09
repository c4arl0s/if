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

# Evaluate $? with if statement, using [[]] and (())

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
