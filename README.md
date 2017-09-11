# puppeteer docker image support japanese font

docker image with  [Google Puppeteer](https://github.com/GoogleChrome/puppeteer) installed

base is [alekzonder/docker-puppeteer](https://github.com/alekzonder/docker-puppeteer)

add NotoSansCJKjp font.

## docker tags

- [v0.10.2](https://github.com/orangesys/docker-puppeteer/tree/v0.10.2)

## install

```bash
docker pull orangesys/docker-puppeteer:v0.10.2
```

## before usage

1. you should pass `--no-sandbox, --disable-setuid-sandbox` args when launch browser

```js
const puppeteer = require('puppeteer');

(async() => {

    const browser = await puppeteer.launch({
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox'
        ]
    });

    const page = await browser.newPage();

    await page.goto('https://www.google.com/', {waitUntil: 'networkidle'});

    browser.close();

})();
```

2. if you got page crash with `BUS_ADRERR` ([chromium issue](https://bugs.chromium.org/p/chromium/issues/detail?id=571394)), increase shm-size on docker run with `--shm-size` argument

```bash
docker run --shm-size 1G --rm -v <path_to_script>:/app/index.js orangesys/docker-puppeteer:v0.10.2
```

## usage

### mount your script to /app/index.js

```bash
docker run --shm-size 1G --rm -v <path_to_script>:/app/index.js orangesys/docker-puppeteer:v0.10.2
```

### custom script from dir

```bash
docker run --rm \
 -v <path_to_dir>:/app \
 orangesys/docker-puppeteer:v0.10.2 \
 node my_script.js
```