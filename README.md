# Bash `if` statement snippets

Examples below are written for **Bash** on **macOS** (for example `/bin/bash` or `bash` from [Homebrew](https://brew.sh)). They use POSIX-compatible `[` / `test`, Bash `[[ ]]`, and arithmetic `(( ))`, all of which work with the Bash version Apple ships.

**Note:** macOS defaults to **zsh** in Terminal; run `bash` first, or save snippets in a script with `#!/bin/bash` and execute it with `bash script.sh`.

---

## Table of contents

1. [if / else](#section-1-if-else)
2. [Exit status (`$?`) with `[[ ]]` and `(( ))`](#section-2-exit-status)
3. [Argument count with `if [ ]` and `(( ))`](#section-3-argument-count)
4. [`if (( ))` with `elif`](#section-4-elif)
5. [Comparing strings in `if`](#section-5-strings)
6. [Using `[ ]` without `if`](#section-6-brackets-alone)
7. [`if` with `test` (without `[ ]`)](#section-7-test)
8. [Using a command directly in `if`](#section-8-command-in-if)
9. [`[[ ]]` for string tests](#section-9-double-bracket)
10. [`test` inside an `if`](#section-10-test-in-if)
11. [`if` / `else` vs `&&` / `||` (and caveats)](#section-11-if-vs-short-circuit)
12. [Multiple conditions](#section-12-multiple)

---

<a id="section-1-if-else"></a>

## 1. if / else

Run two commands in the condition; if both succeed, the `then` branch runs.

```bash
if echo "hello" && echo "World"; then echo "OK"; fi
```

Expected output:

```text
hello
World
OK
```

---

<a id="section-2-exit-status"></a>

## 2. Exit status (`$?`) with `[[ ]]` and `(( ))`

After a command, `$?` is its exit code: `0` means success, non-zero means failure.

**Do not use `if [[ $? ]]`** to mean “did the last command succeed?” In Bash, `[[ string ]]` is true when `string` is non-empty. Both `0` and `1` are non-empty, so this stays true almost always and does **not** reflect success vs failure.

Correct patterns:

```bash
echo "Hello World"
if [[ $? -eq 0 ]]; then
  echo "successful execution (exit code 0)"
else
  echo "execution failed"
fi
```

Using arithmetic (exit code `0` is “false” in `(( ))`, non-zero is “true”):

```bash
echo "Hello World"
if (( $? != 0 )); then
  echo "execution failed (exit code $?)"
else
  echo "successful execution (exit code 0)"
fi
```

---

<a id="section-3-argument-count"></a>

## 3. Argument count with `if [ ]` and `(( ))`

Check the number of positional parameters (`$#`). Typical use at the top of a script.

```bash
if [ "$#" -lt 3 ]; then
  printf "%b" "Error. Not enough arguments.\n"
  printf "%b" "usage: myscript file1 op file2\n"
  # exit 1   # uncomment in a real script
fi
```

Equivalent with arithmetic `(( ))` (Bash; also fine on macOS Bash):

```bash
if (( $# < 3 )); then
  printf "%b" "Error. Not enough arguments.\n"
  printf "%b" "usage: myscript file1 op file2\n"
  # exit 1
fi
```

---

<a id="section-4-elif"></a>

## 4. `if (( ))` with `elif`

```bash
if (( $# < 3 )); then
  printf "%b" "Error. Not enough arguments.\n"
  printf "%b" "usage: myscript file1 op file2\n"
  # exit 1
elif (( $# > 3 )); then
  printf "%b" "Error. Too many arguments.\n"
  printf "%b" "usage: myscript file1 op file2\n"
  # exit 2
else
  printf "%b" "Argument count OK. Proceeding...\n"
fi
```

---

<a id="section-5-strings"></a>

## 5. Comparing strings in `if`

Quote variables to avoid word splitting and empty expansions.

```bash
choice="yes"
if [ "$choice" = "yes" ]; then
  echo "Your choice is yes"
fi
```

Expected output:

```text
Your choice is yes
```

---

<a id="section-6-brackets-alone"></a>

## 6. Using `[ ]` without `if`

The test can stand alone; the `&&` runs the next command only if the test is true.

```bash
result=1
[ "$result" -eq 1 ] && { echo "Result is 1"; }
```

Expected output:

```text
Result is 1
```

Using `=` instead of `-eq` works for string comparison; `-eq` is clearer for integers.

---

<a id="section-7-test"></a>

## 7. `if` with `test` (without `[ ]`)

`[` is another spelling of `test`. Same behavior on macOS.

```bash
if test "$#" -lt 3; then
  echo "try again."
fi
```

If you run that with fewer than three arguments (e.g. inside a script), you get:

```text
try again.
```

---

<a id="section-8-command-in-if"></a>

## 8. Using a command directly in `if`

Prefer putting the command in `if` instead of checking `$?` separately (clearer and avoids races with other commands).

First pattern (checks exit status of `mkdir` explicitly — use `-eq` for integers):

```bash
mkdir directory
if [ "$?" -eq 0 ]; then
  echo "directory was created successfully"
else
  echo "mkdir failed (e.g. directory may already exist)"
fi
```

Preferred: command in the `if` condition:

```bash
if mkdir directory; then
  echo "directory was created successfully"
else
  echo "mkdir failed (e.g. directory may already exist)"
fi
```

On macOS, `mkdir` without `-p` fails if `directory` already exists, which triggers the `else` branch.

---

<a id="section-9-double-bracket"></a>

## 9. `[[ ]]` for string tests

Pattern match (Bash; no globbing surprises on the right unless you intend it):

```bash
if [[ "${var}" == "some_string" ]]; then
  echo "do something"
fi
```

Prefer `-z` (empty) and `-n` (non-empty) over comparing to `""`:

```bash
if [[ -z "${my_var}" ]]; then
  echo "do something"
fi
```

Possible but not preferred:

```bash
if [[ "${my_var}" == "" ]]; then
  echo "do something"
fi
```

---

<a id="section-10-test-in-if"></a>

## 10. `test` inside an `if`

```bash
touch "${HOME}/file.txt"
if test -f "${HOME}/file.txt"; then
  echo "file exists"
else
  echo "file does not exist"
fi
```

Expected output:

```text
file exists
```

---

<a id="section-11-if-vs-short-circuit"></a>

## 11. `if` / `else` vs `&&` / `||` (and caveats)

Explicit `if`:

```bash
if cp file.txt "${HOME}/Desktop/"; then
  echo "Done"
else
  echo "failed"
  exit 1
fi
```

**Note:** Adjust the destination (`"${HOME}/Desktop/"` here); create the directory first if needed.

Compact form:

```bash
cp file.txt "${HOME}/Desktop/" && { echo "Done"; } || { echo "Failed"; exit 1; }
```

**Caveat:** `cmd && a || b` is **not** always equivalent to `if cmd; then a; else b; fi`. If `a` runs but returns a non-zero exit status, `b` can still run. Prefer `if` / `else` when both branches must be mutually exclusive.

---

<a id="section-12-multiple"></a>

## 12. Multiple conditions

Example script logic: combine `[[ ]]` tests with `&&` and `||`. The comment is a reminder to sketch a truth table for your real rules.

```bash
#!/bin/bash

var_one=1

# Only one var might be set or none of them
var_two=
var_three=1

# Only one flag might be set or none of them
flag_one=
flag_two=
flag_three=

# truth table for the condition below (adapt to your real rules)

if [[ "${var_one}" ]] \
  && { [[ "${var_two}" ]] || [[ "${var_three}" ]]; } \
  && { [[ -z "${flag_one}" ]] && [[ -z "${flag_two}" ]] && [[ -z "${flag_three}" ]]; }; then
  echo "flag_one=$flag_one"
  echo "flag_two=$flag_two"
  echo "flag_three=$flag_three"
  echo "all flags are length zero"
  exit 1
fi
```

Running the script:

```text
./if-statement.sh
```

Example output for the variable values above:

```text
flag_one=
flag_two=
flag_three=
all flags are length zero
```
