# The Quick Laravel Security Audit

> This project is in active development. Check back soon!

Doing pentests requires experience and knowledge. This means that often you will need to spend a lot of time to find the vulnerabilities. This is why I created this tool. It will help you to find the most common vulnerabilities in a Laravel application and it will also give you some tips on how to fix them.

The point of this file is to be able to run one quick command and output a list of vulnerabilities that you can fix. This is not a replacement for a full pentest, but lowering the bar for people to do a quick security audit on their Laravel applications.

## About the author

Hi, I'm Clara and I have been working in laravel for close to a decade and have been working in PHP for 15 years. I hold an OSCP certification and have been hacking since I was 10 years old. If you like my work and would like to see me spend more time on this project, [please consider sponsoring me on Github!](https://github.com/sponsors/ClaraLeigh)

## How to use

This tool was designed to be a single command that you can run in your terminal. You can run it like this:

```bash
curl -s https://raw.githubusercontent.com/ClaraLeigh/laravel-security-audit/main/audit.sh | bash
```

This will then output a file called `audit.html` in your current directory. You can open this file in your browser and see the results.

I highly recommend you look at the code before running it. It's a good idea to know what you are running on your machine.

Also it's a good idea to ensure you've added `audit.html` to your `.gitignore` file so you don't accidentally commit it to your repository.

## What it checks

- Your latest installed versions of Laravel and PHP
- It performs a composer audit and npm audit
- It gives you links to quickly check your versions for vulnerabilities
- It prints your routes in a table to allow you to check for any routes that should not be public, or are possibly stale and opening you up to vulnerabilities
- Reviews your project for types and type coverage

## Future plans

I am actively working on this tool. Here is my current hit list likely to be implemented soon:
- Check for insecure php functions
- Quickly review your laravel model policies
- Review for mass assignment vulnerabilities
- Review your models and ensure you have hidden fields that are likely to be sensitive
- Review your middleware
- Send your files to GPT to have it crawl through and look for vulnerabilities
- and more! If you have any suggestions, please open an issue on this repository.

## Why wasn't this a package?

Packages are great! I love them but often I find that packages just add overhead to a project. It becomes one more thing you have to keep up to date. The script that generates the html is intended to be a once off use so that there is no lingering package or dependency to worry about.

I honestly believe we've become far too reliant on packages that do something you could make yourself in a few minutes. They open you up to security vulnerabilities and can be abandoned. They also often bring in features you might not want or need. So, next time you are installing a package, ask yourself "Do I really need this? Could I make this myself?". You might be surprised at how much you can do yourself.

## Contributing and feedback

I would love to hear your feedback on this tool. If you have any suggestions or ideas, please open an issue on this repository. If you would like to contribute, please open a pull request. The more eyes on this, the better!