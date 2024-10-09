# Project Setup

Since the purpose of this project is to be production-ready, we won't take any shortcuts.
The following concepts are central to the project:
- version control
- automatic testing & delivery

## Version Control

For the automation part, we'll be using [GitHub Actions](https://docs.github.com/en/actions).
This is unfortunately a proprietary automation platform by GitHub, which is owned by Microsoft.
However, it is provided for free and many developers have experience with it, so it is the most pragmatic choice for now.
I'm keeping my eyes open for more FOSS-friendly alternatives.
So, you specifically need a repository on GitHub for the purposes of this project.

If you already have a suitable repository, e.g. a [rust-exercises](https://github.com/senekor/rust-exercises) repo, you can simply add all paekli-rs related things in a subdirectory called `paekli-rs/`.
Otherwise, [create a new repository](https://github.com/new) on GitHub.
You may name it whatever you like, but this book assumes you named it `peakli-rs`.

You should also create a [cargo workspace](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html) in your new repo.
We will be adding multiple crates during the project, a workspace makes it easier to manage them.
Some of our project automation also relies on its presence.
Make sure there is a file called `Cargo.toml` at the root of your repository with the following content:

```toml
[workspace]
resolver = "2"
members = []

[workspace.package]
repository = "https://github.com/<YOUR_USER_NAME>/<YOUR_REPO_NAME>"
```

The `members` list doesn't have to be empty, in case you're using an existing repo.
Replace the `repository` key with the correct url, it's needed for the project automation later.

## CI/CD

If you already have GitHub Actions set up to automatically test and compile your code, you can skip this section.

In order to facilitate a "continuous integration" workflow, we need to make sure that coding standards are uphelp and tests pass on the main branch.
GitHub Actions provides this automation.
Create a new automation workflow by adding a file at `.github/workflows/test.yml` (from the root of your repository).

```yaml
name: Test
on: push

jobs:
  ci:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Ensure standard formatting
        run: cargo fmt --check
      - name: Check code quality with clippy
        run: cargo clippy -- --deny warnings
      - name: Run tests
        run: cargo test
```

This will check that:
1. Your code is properly formatted.
1. Clippy doesn't have any suggestions for improvement.
1. All tests are passing.

If you would like to know more about the syntax of this file, the capabilities of GitHub Actions and how to write such a workflow yourself, check out the [GitHub Actions documentation](https://docs.github.com/en/actions).

For the "continuous delivery" part, we need to make sure that any new features we develop can quickly be delivered into the hands of our users.
There is an awesome project called `cargo-dist`, which can create a GitHub Actions workflow that automatically compiles your program to be downloaded by users whenever you push a new version tag.
That's exactly what we need!

Create a stub for the CLI component so you have an actual Rust package that can be compiled:

```sh
cargo add paekli-cli
```

This command should automatically add the new package to your cargo workspace, so the `members` list in the top-level `Cargo.toml` should contain the string `"paekli-cli"`.
It it doesn't, something in your workspace manifest is probably misconfigured.

Change the code in `paekli-cli/src/main.rs` as follows:

```rust
fn main() {
    panic!("Paekli LLC is currentli closed 😢");
}

#[test]
#[should_panic]
fn paekli_llc_is_closed() {
    main();
}
```

That's a decent enough stub, we even have a test for our continuous integration workflow to run.

Next, install `cargo-dist` and initialize it.
During initialization, you will be prompted about which platforms you want to build for, which installers to generate and maybe more.
It mostly doesn't matter for the purpose of this project.
Just make sure you enable at least one installer that's applicable to you so you can test the results.
`shell` should be enough.

```sh
cargo install cargo-dist
cargo dist init
```

You may receive the following or a similar error:

```txt
× Github CI support requires you to specify the URL of your repository
```

If you do, make sure your workspace manifest (`Cargo.toml` at the root of your repository) contains the url to your repository and the package manifest (`Cargo.toml` in the `paekli-cli` directory) references it:

```toml
# Cargo.toml
[workspace.package]
repository = "https://github.com/<YOUR_USER_NAME>/<YOUR_REPO_NAME>"
# paekli-cli/Cargo.toml
[package]
name = "paekli-cli"
version = "0.1.0"
edition = "2021"
repository.workspace = true
```

Run `cargo dist` again until you receive no errors.
At this point, you should have a generated file at `.github/workflows/release.yml`.

To enjoy the fruits of your labor, trigger your first release workflow as such:

```sh
# Commit and push all your current changes.
git add --all ; git commit ; git push
# Create and push a version tag.
# cargo-dist recognizes this and releases all packages with a matching version.
git tag v0.1.0 ; git push --tags
```

When you navigate to your repository on GitHub, you should see the release workflow running under the "Actions" tab.
Once that is complete, go back to the front page of your repo.
There should be a new release in the sidebar on the right.
If you click on that, you should see a list of all compiled binaries ready for download as well as a simple shell command for installation, assuming you enabled that during `cargo dist init`.

```admonish check title="Where to go next"
Congratulations!

Now that you're ready to do some serious software development, it's time to choose your first component to implement!
Unless you have a strong desire to do something else, I recommend to **start with the [CLI](cli.md)**.
It is the easiest component to implement and its guide is the most detailed.
The other guides are still self-contained, but they provide fewer explanations of steps that are identical or similar for all components.
```
