Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E92BF10.9000301@cam.ac.uk>
Date: Mon, 10 Oct 2011 10:46:56 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Linus Walleij <linus.walleij@linaro.org>,
 Zoltan Devai <zoss@devai.org>,
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 linux-iio@vger.kernel.org,
 Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
References: <1318178172-7965-1-git-send-email-zoss@devai.org> <1318178172-7965-5-git-send-email-zoss@devai.org> <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com> <4E92BE19.4060907@cam.ac.uk>
In-Reply-To: <4E92BE19.4060907@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/10/11 10:42, Jonathan Cameron wrote:
> On 10/10/11 02:29, Linus Walleij wrote:
>> 2011/10/9 Zoltan Devai <zoss@devai.org>:
>>
>>> Signed-off-by: Zoltan Devai <zoss@devai.org>
>>> ---
>>>  arch/arm/mach-spmp8000/adc.c                      |  465 +++++++++++++++++++++
>>>  arch/arm/mach-spmp8000/include/mach/spmp8000adc.h |   29 ++
>>
>> I think we stopped stuffing misc drivers under arch/arm/*
>>
>> And stuffing them under drivers/misc/* won't be popular either.
>>
>> IIO has some ADCs in drivers/staging/iio/adc
>> these seem all to be intended to be used from userspace.
> Yeah, we've had various discussions about adding support for
> in kernel users. Its always fallen on the fact that no one
> has had the time to write the code to allow it all to be
> linked up.  Right now it's a case of drivers providing their
> own interfaces if they want to allow this.
> Mark Brown has raised this issue before so I've cc'd him.
> 
> For reference of those not following the original thread (based
> on a quick scan of the driver code in question).
> 
> Driver has two callback sets:
> 
> 1) Touch panel reads (I guess going straight to an input driver)
> (1 of these only). This is annoyingly tied up with the more general
> adc registers.
> 2) General purpose adc callbacks. 
> 
> Both are driven off an interrupt, but data ready
> appears to manually driven (so software triggered sampling then data
> ready signal when sampling is done for a single channel).
> 
> So what are these callbacks used for?  Note they all run as
> interrupt top halves...
> 
> Options at current time are:
> 
> mfd supporting input device and either hwmon or iio device.
> 
> A driver that hosts both a hwmon / iio and an input device.
> 
> Be brave (+ have a lot of time) and propose patches adding the relevant
> tying together code to allow iio drivers to be queried in kernel.
> It shouldn't be that bad actually if you solve the how to work
> out which device / channel you want in a consistent way.
> 
> It really depends on what those general adc callbacks get used for.
Ah, just taken a look at your dts file.

Looks like some are used for 'analog-keys'.  So input? If so this
should probably be an entirely input driver for now.

> 
>>
>> There are a few in-kernel ADCs all over the kernel tree
>> for various specific purposes.
>>
>> I don't know where we should go with this kind of stuff,
>> really :-/
>>
>> Yours,
>> Linus Walleij
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
