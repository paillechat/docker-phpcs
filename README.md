# Docker image for `phpcs`

[![](https://img.shields.io/docker/pulls/paillechat/docker-phpcs.svg)](https://hub.docker.com/r/paillechat/docker-phpcs)
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)

View **[Dockerfile](https://github.com/paillechat/docker-phpcs/blob/main/Dockerfile)** on GitHub.

[Docker hub](https://hub.docker.com/r/paillechat/docker-phpcs)

Tiny Alpine-based multistage-builld dockerized version of [phpcs](https://github.com/squizlabs/PHP_CodeSniffer)<sup>[1]</sup>.
The image is built nightly against multiple stable versions and pushed to Dockerhub.

<sup>[1] Official project: https://github.com/squizlabs/PHP_CodeSniffer</sup>


## Docker mounts

The working directory inside the Docker container is **`/app/`** and should be mounted locally to
the root of your project.


## Usage

### Basic
```bash
$ docker run --rm -v $(pwd):/app paillechat/docker-phpcs .

----------------------------------------------------------------------
FOUND 4 ERRORS AFFECTING 3 LINES
----------------------------------------------------------------------
 2 | ERROR | [ ] Missing file doc comment
 5 | ERROR | [x] First condition of a multi-line IF statement must
   |       |     directly follow the opening parenthesis
 6 | ERROR | [x] Line indented incorrectly; expected at least 4
   |       |     spaces, found 1
 6 | ERROR | [x] Closing brace must be on a line by itself
----------------------------------------------------------------------
PHPCBF CAN FIX THE 3 MARKED SNIFF VIOLATIONS AUTOMATICALLY
----------------------------------------------------------------------
```

### Custom standard
Custom standards must be mounted inside the container to `/usr/bin/CodeSniffer.conf `
```bash
# Via command line
$ docker run --rm -v $(pwd):/app -v CodeSniffer.conf:/usr/bin/CodeSniffer.conf paillechat/docker-phpcs .
```


## License

**[MIT License](LICENSE)**
