Return-Path: <SRS0=p7ub=ZB=baylibre.com=bgolaszewski@kernel.org>
MIME-Version: 1.0
In-Reply-To: <3293536.XfDnNLEWhh@ws-stein>
References: <CAMpxmJUHfo7FRzzx7MxdADyVMYZiSLEPCtCSDLkq540M1fZTkg@mail.gmail.com>
 <4449310.gRYbpx7f9x@ws-stein> <CAMpxmJUAKOqcBQ=p9Y=wrFk7Ms=dVGCRDWhmiijuUMQ2-MAHug@mail.gmail.com>
 <3293536.XfDnNLEWhh@ws-stein>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 19 Jan 2017 15:59:57 +0100
Message-ID: <CAMpxmJWYCD-a1azG2sbHCFa8MQngsJdhTnOgCjnidO9zGVWp9Q@mail.gmail.com>
Subject: Re: libgpiod v0.1: C library and command-line tools for controlling GPIOs
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-gpio <linux-gpio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Alexandre Courbot <gnurou@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2017-01-19 15:30 GMT+01:00 Alexander Stein
<alexander.stein@systec-electronic.com>:
> On Thursday 19 January 2017 15:12:43, Bartosz Golaszewski wrote:
>> 2017-01-19 15:05 GMT+01:00 Alexander Stein
>>
>> <alexander.stein@systec-electronic.com>:
>> > Hi,
>> >
>> > On Wednesday 18 January 2017 16:48:08, Bartosz Golaszewski wrote:
>> >> I'd like to announce the first release of libgpiod. The project
>> >> consists of a C library and a set of command-line tools for
>> >> controlling GPIOs over the new character device interface.
>> >>
>> >> The tools support reading & setting values, keeping the lines
>> >> exported, finding GPIO lines by name, monitoring events etc.
>> >>
>> >> The source code can be found at: https://github.com/brgl/libgpiod
>> >
>> > Cool thing. thanks! One bug found:
>> > https://github.com/brgl/libgpiod/blob/master/src/tools/gpiomon.c#L31
>> >
>> > shortopts is missing 's' so the following occurs:
>> >> gpiomon -l -r -s --num-events=1 gpiochip2 1
>> >> gpiomon: invalid option -- 's'
>> >> gpiomon: try gpiomon --help
>> >>
>> >> gpiomon -l -r --silent --num-events=1 gpiochip2 1
>> >
>> > works as expected
>>
>> Thanks, fixed in git.
>
> Thanks, also for defines of GPIOHANDLE_REQUEST_INPUT and friends you actually
> need kernel headers >=4.8. README.md says >=4.7
>

Fixed as well. Would you mind opening a github issue in the future to
keep track of issues?

Thanks,
Bartosz Golaszewski
