Return-Path: <lars@metafoo.de>
Message-ID: <516A9F1B.5060407@metafoo.de>
Date: Sun, 14 Apr 2013 14:20:43 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3]  staging:iio:adis16130 bits and bobs.
References: <1365938625-21778-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1365938625-21778-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/14/2013 01:23 PM, Jonathan Cameron wrote:
> Hi All,
> 
> Had a few bored moments so thought I'd take a quick look at this driver.
> The read function is rather odd to say the least, Lars/Michael could one of
> you take a quick look at this.  Right now it does an spi sync that I think
> should read the data and follows it with an additional read.  I can't
> immediately see what the read is for.

Yea I noticed that too, I think that read was introduced by accident during
some refactoring. See
https://github.com/lclausen-adi/linux-2.6/commit/1889f3a5d291ad57a5faed83652c465de29d740f

Unfortunately I couldn't get my hands on a adis16030 board yet to test those
changes otherwise I'd already submitted them.

> 
> Also note the introduction of IIO_INT_PLUS_PICO which is going to be common
> with 24 bit plus devices.  For now I've ignored the write case as this driver
> doesn't support it, but it will be needed if for example 24/16 bit options
> are both supported for this driver.
> 
> Note to my mind this device is far enough away from the other adis parts
> in interface to justify it's own driver.

Yes.

> 
> Also could someone check my scale/offset calcs are right. It's Sunday
> morning and I'm not feeling all that awake ;)
> 

For temp scale you seem to be off by a factor of 1000000 (well or maybe
I'm), otherwise I got the same.

> Thanks,
> 
> Jonathan 
> 
> Jonathan Cameron (3):
>   iio:Add an IIO_VAL_INTO_PLUS_PICO return type for read_raw callbacks.
>   staging:iio:gyro:adis16130 drop unused list.h header.
>   staging:iio:gyro:adis16130 add offset and scale info mask elements.
> 
>  drivers/iio/industrialio-core.c           |  5 +++
>  drivers/staging/iio/gyro/adis16130_core.c | 58 +++++++++++++++++++++++++------
>  include/linux/iio/types.h                 |  1 +
>  3 files changed, 53 insertions(+), 11 deletions(-)
> 
