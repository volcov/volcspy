# Volcspy

Volcspy is a tool to identify "forced" reviews

## selection criteria

from a list of reviews the choice is made through the following steps:

  1. sum of the number of times each employee appears in the list
  2. selects the first three
  3. look for the reviews that contain the set of those selected in step 2

## Installation

You will need

* Elixir 1.11.2
* Erlang 22.3.4.10

You can follow the instructions:
<https://elixir-lang.org/install.html>

## Installation with asdf

If you are an `asdf` user, follow the steps:

Add elixir plugin

``` sh
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
```

Add erlang plugin

```sh
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
```

Install the required versions.

```sh
asdf install
```

## Running

before running we need to set the `VOLCSPY_BASE_URL` environment variable, you can export for this terminal session with

```sh
export VOLCSPY_BASE_URL="${YOUR_URL}"
```

and after we can run `Volcspy` with

```sh
iex -S mix
```

or if you prefer, can set the environment at the same time of running with

```sh
VOLCSPY_BASE_URL="${YOUR_URL}" iex -S mix
```

> Note: for this experiment YOUR_URL= "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/"

## Scanning

into the `iex` just call

```elixir
iex> Volcspy.scan()
```

Then you will have the suspects

## Testing

To run tests just type

```sh
mix test
```

---

This is it, have a good investigation xD
