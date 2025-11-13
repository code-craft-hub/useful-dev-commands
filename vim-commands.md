
### Vim command

```bash
vim file.txt

To insert text:
Press i → you’re now in insert mode. Type normally.

To exit insert mode back to normal:
Press Esc.

To run commands (save, quit, etc.):
Press : in normal mode → enters command mode.

3. Editing Text in Vim

While in normal mode:

i → insert before cursor

I → insert at the beginning of the line

a → append after cursor

A → append at the end of the line

o → open a new line below

O → open a new line above

r → replace a single character

R → replace multiple characters (overwrite mode)

x → delete character under cursor

dd → delete current line

yy → yank (copy) current line

p → paste after cursor

P → paste before cursor

u → undo

Ctrl + r → redo

4. Moving Around

h → left

j → down

k → up

l → right

0 → beginning of line

^ → first non-blank character of line

$ → end of line

w → jump to next word

b → jump back a word

gg → go to top of file

G → go to bottom of file

5. Saving and Exiting

In command mode (press : first):

:w → save file

:q → quit Vim

:wq → save and quit

:x → save and quit (same as :wq)

:q! → quit without saving ```
