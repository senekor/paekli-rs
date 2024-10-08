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

If you already have a suitable repository, e.g. a [rust-exercises](https://github.com/senekor/rust-exercises) repo, you can simply add all paekli-rs related things in a subdirectory called `paekli-rs/`.
Otherwise...

[Create a new repository](https://github.com/new) on GitHub.
You may name it whatever you like, but this book assumes you named it `peakli-rs`.
If you keep that name, it will be more convenient to copy-paste commands from the book.
Next, clone the repo to your local machine.
You should also create a [cargo workspace](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html) in your new repo.
We will be adding multiple crates during the project, a workspace makes it easier to manage them.
Add the following content to a file called `Cargo.toml` at the root of your repository:
```toml
[workspace]
resolver = "2"
members = []
```

```admonish check title="Where to go next"
Now you're ready to choose your first component to implement!
Unless you have a strong desire to do something else, I recommend to **start with the [CLI](cli.md)**.
It is the easiest component to implement and its guide is the most detailed.
The other guides are still self-contained, but they provide fewer explanations of steps that are identical or similar for all components.
```
