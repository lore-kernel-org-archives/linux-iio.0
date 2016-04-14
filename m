Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1604121106070.4383@pmeerw.net>
References: <1460451311-9819-1-git-send-email-linus.walleij@linaro.org>
	<alpine.DEB.2.02.1604121106070.4383@pmeerw.net>
Date: Thu, 14 Apr 2016 09:32:22 +0200
Message-ID: <CACRpkdZyuNErX-qqawJF5+W1RfiD9YE1t7NfyQGqQetGfoz=PA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: tools: generic_buffer: auto-enable channels
From: Linus Walleij <linus.walleij@linaro.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 12, 2016 at 11:14 AM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:

>> +int enable_disable_all_channels(char *dev_dir_name, int enable)
>
> could be static?
> well, nothing in generic_buffer.c is...

OK I will make it static, and then submit a separate patch to staticize the rest
of generic_buffer.c local functions.

>> +     dp = opendir(scanelemdir);
>> +     if (!dp) {
>
> maybe perror() can be used here, it's used for closedir() check

perror() does not support arguments.
perror("foo"); is OK.
perror("%s: foo", __func__); does not work.

So we have to use printf(stderr, ....);

>> +     int autochannels = 0;
>
> maybe an enum for autochannels? it can be 0/1/2

OK. It breaks a bit with the style of the file, but I will
submit a version like so.

>> +static inline int check_suffix(const char *str, const char *suffix)
>
> prefix with iioutils_ maybe?

OK

>> +     return strlen(str) > strlen(suffix) &&
>
> it should be >= probably such that
> check_suffix("abc", "abc") is 1, currently returns 0

OK fixed it, nice catch!

Yours,
Linus Walleij
