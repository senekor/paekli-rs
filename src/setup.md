# Project Setup

Since the purpose of this project is to be production-ready, we won't take any shortcuts.
The following concepts are central to the project:
- version control
- automatic testing
- automatic deployment

For the automation part, we'll be using [GitHub Actions](https://docs.github.com/en/actions).
This is unfortunately a proprietary automation platform by GitHub, which is owned by Microsoft.
However, it is provided for free and many developers have experience with it, so it is the most pragmatic choice for now.
I'm keeping my eyes open for more FOSS-friendly alternatives.

If you already have a suitable repository, e.g. a [rust-exercises](https://github.com/senekor/rust-exercises) repo, you can simply add all paekli-rs related things in a subdirectory.
Otherwise...

[Create a new repository](https://github.com/new) on GitHub.
You may name it whatever you like, but this book assumes you named it `peakli-rs`.
If you keep that name, it will be more convenient to copy-paste commands from the book.

Lastly, clone the repo to your local machine.
Unless otherwise specified, assume that any commands you're asked to run should be run in the root of your `paekli-rs` repository.

```admonish check title="Where to next"
Now you're ready to choose your first component to implement!
Remember, I recommend starting off with the [CLI](cli.md).
```
