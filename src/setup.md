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

[Create a new repository on GitHub](https://github.com/new?name=paekli-rs).
It must be called `paekli-rs`, since some of the automation & tooling relies on that name.
Making it generic would be overly complex and the error messages are bad, so do yourself a favor and stick to the name `paekli-rs`.
Also, don't add your code for this project to a subdirectory of a different repository where you might be storing other Rust exercises already.
This will cause unnecessary headaches with mismatched paths in scripts.

You also need to create a [cargo workspace](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html) in your new repo.
We will be adding multiple crates during the project, a workspace makes it easier to manage them.
Some of our project automation also relies on its presence.
Add a file called `Cargo.toml` at the root of your repository with the following content:

```toml
[workspace]
resolver = "2"
members = []

[workspace.package]
repository = "https://github.com/<YOUR_USERNAME>/paekli-rs"
```

Fill in your username in the `repository` url, it's needed for the project automation later.

## CI/CD

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

Change the code in `paekli-cli/src/main.rs` to the following:

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

That's a good enough stub, we even have a test for our continuous integration workflow to run.

Next, install `cargo-dist` and initialize it.
During initialization, you will be prompted about which platforms you want to build for, which installers to generate and maybe more.
It mostly doesn't matter for the purpose of this project.
Just make sure you enable at least one installer that's applicable to you so you can easily test the results.
`shell` should be enough.

```sh
cargo install cargo-dist
cargo dist init
```

````admonish error title="Github CI support requires you to specify the URL of your repository" collapsible=true

If you're getting that error, there is something wrong with your `Cargo.toml` files.

First, make sure your top-level `Cargo.toml` contains the url to your repository
You have to replace your GitHub username in the url!
```toml
[workspace.package]
repository = "https://github.com/<YOUR_USERNAME>/paekli-rs"
```

Next, make sure the `Cargo.toml` in the `paekli-cli` directory contains a reference to the url in the workspace:

```toml
[package]
# ... other keys like name, version, edition ...
repository.workspace = true
```

Continue once you can run `cargo dist init` without errors.
````

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
