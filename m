Return-Path: <SRS0=pjc4=ZB=gmail.com=angelo.compagnucci@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMpxmJUFW6Sy=xd_qLPiwTk5CwQMWp-N1k6xxDwoZaz6qYeMcA@mail.gmail.com>
References: <CAMpxmJUHfo7FRzzx7MxdADyVMYZiSLEPCtCSDLkq540M1fZTkg@mail.gmail.com>
 <CACRpkdbq5aFZZfNN1UxjrxTzsHQBdkLcz9LCx3BSp-JoirXR6A@mail.gmail.com> <CAMpxmJUFW6Sy=xd_qLPiwTk5CwQMWp-N1k6xxDwoZaz6qYeMcA@mail.gmail.com>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Thu, 19 Jan 2017 11:58:13 +0100
Message-ID: <CA+TH9VmGzZY1x+O9vFvQzdZGhtVhDme2-GmPj+0OdF1xarPtkw@mail.gmail.com>
Subject: Re: libgpiod v0.1: C library and command-line tools for controlling GPIOs
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-gpio <linux-gpio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Alexandre Courbot <gnurou@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Bartosz Golaszewski,

2017-01-19 11:10 GMT+01:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> 2017-01-19 10:34 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Wed, Jan 18, 2017 at 4:48 PM, Bartosz Golaszewski
>> <bgolaszewski@baylibre.com> wrote:
>>
>>> I'd like to announce the first release of libgpiod. The project
>>> consists of a C library and a set of command-line tools for
>>> controlling GPIOs over the new character device interface.
>>
>> Nice!
>>
>> Have you thought about adding bindings for higher order
>> languages etc that I think can make GPIO programming a bliss?
>>
>
> I have thought about soooo many things I could do, but the problem is
> - as usual - time I can devote to this project. ;) Anyways: I'll
> welcome any contribution, so if you'll happen to have some time to do
> it, I'll surely include it.
>
>> I created some for Control Groups at a point, using ctypes:
>> https://sourceforge.net/p/cgfreak/code/ci/master/tree/pylibcgroup.py
>>
>
> FYI check out libsigrok - it generates python bindings from C++ using
> swig - maybe this would be a good approach to decrease the amount of
> work needed.

I'd really like to help here, I have a bit of previous experience with
python bindings to c and I don't think it's a tremendous amount of
work.
I'm planning to fork your project next weeks and trying to do something!

>
>> The point is not that Python would be so great (some think
>> so) more that this kind of stuff makes GPIOs so much more
>> accessible, apart from good old C.
>>
>
> Yep, certainly agree. This is definitely a feature I'd like to have in
> the future.
>
> Best regards,
> Bartosz Golaszewski
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
