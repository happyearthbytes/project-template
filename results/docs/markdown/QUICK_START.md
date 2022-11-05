
Quick Start
==============================================================================

## Basic

Run `make` with no arguments to see the list of convenience functions.

``` bash
> make
```

## Initial Configuration

### Setup

``` bash
> # clone the repo and perform setup operations to enable access of the development environment
> git clone <repo-name>.git --branch develop
> cd <repo-name>
> make setup
```

### Access Development Environment

``` bash
> TODO
```

## Commands to make stuff happen

### Help

```console
> ./make.py
> # -OR-
> ./make.py --help
```

### Build

#### build everything

```console
> ./make.py --build all
```

#### build one target

```console
> ./make.py --build apps/cpp_app
```

### Test

#### test everything

```console
> ./make.py --test all
```

#### test one target

```console
> ./make.py --test apps/cpp_app
```

### Verify

#### verify everything

```console
> ./make.py --verify all
```

#### verify one target

```console
> ./make.py --verify apps/caf_app
```

### Scan

#### scan everything

```console
> ./make.py --scan all
```

#### scan one target

```console
> ./make.py --scan apps/cpp_app
```

### Document

### document everything

```console
> ./make.py --docs all
```

### document one target

```console
> ./make.py --docs apps/cpp_app
```
