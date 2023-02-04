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

# Evaluate $? with if statement

```bash
echo "Hellow World!"
```

```bash
if (( $? )) ; then echo failed ; else echo OK; fi
```

```console
OK
```

```bash
cd mytmp
```

```bash
if (( $? )); then rm * ; fi
```
