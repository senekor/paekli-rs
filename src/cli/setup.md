# Setup

## Initializing a new package

We're going to keep our CLI in the directory `paekli-rs/`.
Here are the commands to let cargo bootstrap it:

```sh
cd paekli-rs
cargo new paekli-cli
```

You should now have two new files:
- `paekli-cli/Cargo.toml`
- `paekli-cli/src/main.rs`

...as is the case with any new executable Rust package.

Also note that the `members` key of the top-level `Cargo.toml` should have been modified automatically to include your new package:

```toml
members = ["paekli-cli"]
```

It may look different if you already have other packages in your repo and or `paekli-cli` is in a subdirectory.
That's fine, as long as it is present somehow.

## Shipping the first version

Before we add any features, we need to make sure we can ship our software efficiently.
Let's just change the print statement in the main function for now:

```rust
fn main() {
    println!("Paekli LLC is currentli closed 😢");
}
```

Remembering the release-workflow we've already seen during the workshop, all we have to do is commit our changes and push a new version tag.
You have probably already "used" some version tags in your repository, so just pick the next higher one to release the first version of paekli-cli, for example `v0.1.2`.

```toml
# paekli-cli/Cargo.toml
version = "0.1.2"
```

```sh
git add --all
git commit
git push
git tag v0.1.2
git push --tags
```

```admonish check title="Release"
That should do the trick!
It's still a good idea to keep an eye on the release job on GitHub and try out the finished executable manually.
```
