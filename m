Return-Path: <rdunlap@xenotime.net>
Message-ID: <4E95D71F.800@xenotime.net>
Date: Wed, 12 Oct 2011 11:06:23 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, greg@kroah.com,
 Michael.Hennerich@analog.com
Subject: Re: [PATCH] staging:iio: gpio build dependency fixing
References: <1318413453-7702-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1318413453-7702-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/12/2011 02:57 AM, Jonathan Cameron wrote:
> Numerous drivers either had pointless includes of gpio.h
> or should have been dependent on GENERIC_GPIO and were not.
> Conversion of ads1210 to use array registration triggered
> build failures that highlighted all was not well.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> Reported-by: Randy Dunlap <rdunlap@xenotime.net>

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Thanks.

> ---
> 
> Randy pointed out the issue with ad2s1210 triggered by
> building without GENERIC_GPIO.  This motivated a quick
> use of git grep on all the drivers and this patch fixes
> all cases where there should have been a dependency,
> or where they was and shouldn't have been (be it implied
> by gpio.h includes).
> 
> One has to wonder what the point in having stubs for the
> array calls is. I'll post on this point separately shortly.
> 
> I have no idea what the sca3000 was checking those gpios
> for. It is probably lost somewhere in history but clearly
> doesn't make sense.
> 
> Jonathan
>  drivers/staging/iio/accel/Kconfig          |    1 +
>  drivers/staging/iio/accel/adis16204_core.c |    1 -
>  drivers/staging/iio/accel/sca3000_core.c   |    7 +++----
>  drivers/staging/iio/adc/Kconfig            |    1 +
>  drivers/staging/iio/addac/Kconfig          |    1 +
>  drivers/staging/iio/dac/ad5504.c           |    1 -
>  drivers/staging/iio/dac/ad5624r_spi.c      |    1 -
>  drivers/staging/iio/dac/ad5686.c           |    1 -
>  drivers/staging/iio/dac/ad5791.c           |    1 -
>  drivers/staging/iio/gyro/adis16080_core.c  |    1 -
>  drivers/staging/iio/gyro/adis16260_core.c  |    1 -
>  drivers/staging/iio/gyro/adxrs450_core.c   |    1 -
>  drivers/staging/iio/magnetometer/Kconfig   |    1 +
>  drivers/staging/iio/meter/ade7753.c        |    1 -
>  drivers/staging/iio/meter/ade7754.c        |    1 -
>  drivers/staging/iio/meter/ade7758_core.c   |    1 -
>  drivers/staging/iio/meter/ade7759.c        |    1 -
>  drivers/staging/iio/meter/ade7854.c        |    1 -
>  drivers/staging/iio/resolver/Kconfig       |    2 ++
>  19 files changed, 9 insertions(+), 17 deletions(-)


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
