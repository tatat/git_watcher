# Git repository watcher

## Install

```sh
git clone <ME> <TO>
cd <TO>
bundle install --path vendor/bundle
```

## Setting

```sh
cp config/settings.yml.sample config/settings.yml
```

## Run

```sh
bundle exec guard -i -w <REPOSITORY>
```
