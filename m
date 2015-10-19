Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34069 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbJSMiQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2015 08:38:16 -0400
Received: by igbni9 with SMTP id ni9so53302141igb.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2015 05:38:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5624E0D4.6040205@metafoo.de>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
	<5624C9C5.6000002@metafoo.de>
	<CAGhQ9VyMbSEEtvaT9R1Pdm4FQf0AzGYWHKMkTHn=rfRHecUXtw@mail.gmail.com>
	<5624E0D4.6040205@metafoo.de>
Date: Mon, 19 Oct 2015 14:38:15 +0200
Message-ID: <CAGhQ9VwWDF8CnGOD3TwkOD56+bLF2QAPrHMk4Zpb89qY6zzx_g@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: add Freescale MMA7455L 3-axis accelerometer driver
From: Joachim Eastwood <manabian@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19 October 2015 at 14:23, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/19/2015 02:19 PM, Joachim Eastwood wrote:
>>>> +static int __init mma7455_modinit(void)
>>>> +{
>>>> +     int ret;
>>>> +#if IS_ENABLED(CONFIG_I2C)
>>>> +     ret = i2c_add_driver(&mma7455_i2c_driver);
>>>> +     if (ret)
>>>> +             pr_err("failed to register MMA7455L I2C driver: %d\n", ret);
>>>> +#endif
>>>> +#if IS_ENABLED(CONFIG_SPI_MASTER)
>>>> +     ret = spi_register_driver(&mma7455_spi_driver);
>>>> +     if (ret)
>>>> +             pr_err("failed to register MMA7455L SPI driver: %d\n", ret);
>>>> +#endif
>>>
>>> I know there are a fair amount of bad examples in the IIO tree for this,
>>> which do the same thing. But the SPI and the I2C parts should go into
>>> different modules, otherwise you run into issues if one of them is built-in
>>> while the other is built as a module. The bmg160 gyro driver is a good
>>> example on how to do handle this.
>>
>> Ok, I semi-copied from a ASoC CODEC driver. I'll take a look at how
>> bmg160 handles it.
>
> We deprecated this style in ASoC as well. All new drivers that support both
> SPI and I2C always come with a foobar-spi.c and foobar-i2c.c file. Not all
> drivers have been updated to this new scheme yet, but I think the majority
> follows it by now.

I see.

Only one of the Wolfson CODEC drivers has been split this way in Linus
master it seems and it was one of these I took as a template.


regards,
Joachim Eastwood
