# ✨ paekli-rs ✨

This is a guide for an exercise project in Rust.
It is intended as the next thing to do after reading [The Rust Programming Language](https://doc.rust-lang.org/book/).

The aim of paekli-rs is to bridge the gap between _the book_ and production-ready code, emphasizing among other things:
- library usage
- inter-process communication
- integration in a polyglot environment
- automated testing and deployment (CI/CD)
- having lots of fun! 😃

## The Topic

We humans learn best when we're having fun, so the application will be themed as a simulation of a postal service.
In practice, that's just a messaging application.
This topic was chosen because its feature set is very flexible and can adapt to what and how much **you** want to do.

Our postal service could be sending "packages" around, but that word has another meaning in the software world.
So, we'll be using the less ambiguous and more fun term ✨ **paekli** ✨ to refer to deliverables in our business domain.

```admonish info title="Etymology" collapsible=true
Päkli is [Swiss German](https://en.wikipedia.org/wiki/Swiss_German) and derives from Paket, the German word for package.

A notable difference is that Päkli is a [diminutive](https://en.wikipedia.org/wiki/Diminutive).
Swiss German uses the diminutive form much more generously than standard German, which makes the entire language a little less serious and a little more cute.

Whenever it's impossible or inconvenient to use proper [diaeresis](https://en.wikipedia.org/wiki/Diaeresis_(diacritic)), Germans will replace ä, ö, ü with ae, oe, ue.
As this book is not targeted to Germans specifically, that's exactly what we'll do.
```

## Choose your own components

This book is structured around self-contained guides for what we'll call _components_.
You can choose to implement almost any combination of them in almost any order.
In its simplest form, the application can be a single component, e.g. a CLI app, without any integrations with other components.
If you choose to go the extra mile, the application can grow into a diverse set of interacting clients and servers.

For example, a python script might call into a Rust library and send a paekli to an http server which live-updates a wasm-based browser app over websocket!
So cool! 🤩

As you can see in the sidebar, the components are loosely categorized into **clients**, **servers** and **storage backends**.
- Clients can be stand-alone and may use servers and storage backends.
- Servers can be stand-alone, but are probably difficult to use without a client.
  They may also use storage backends.
- Storage backends can't be stand-alone, as their only purpose is to be used by clients and servers.

Unless you have a strong desire to do something else, I recommend to **start with the [CLI](cli.md)**.
It is the easiest component to implement and its guide is the most detailed.
The other guides are still self-contained, but they provide fewer explanations of steps that are identical or similar for all components.

```admonish tip title="Choose your own difficulty"
The guides are supposed to be at moderate to low difficulty, although there is some variability.
If you'd like a bigger challenge, you are always welcome to go off the beaten path!
Are you a web developer and find the HTTP server guide boring?
Invent a new feature that requires you to use query params and try to make them type-safe.
You get the idea.
The more you go off the beaten path, the more difficult it will be to integrate different components, which might be exactly the challenge you're looking for.
```

## Requirements

The book assumes that you're using a Unix-like operating system.
Linux is officially supported, but Mac should work just as well.
If you're on Windows, you should be fine by using [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).
However, please do not open issues related to that.

You also need to be familiar with version control, i.e. [git](https://git-scm.com/).
If you aren't, paekli-rs is probably not right for you.
This book assumes you use git, but if you know what you're doing, feel free to use a git-compatible alternative like the excellent [jujutsu](https://github.com/martinvonz/jj).

---

If you're ready to get started, **proceed to the [project setup](./setup.md)**.
