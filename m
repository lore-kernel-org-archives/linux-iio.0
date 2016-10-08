Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH v3 2/2] staging: iio: ad7606: fix improper setting of
 oversampling pins
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
 outreachy-kernel@googlegroups.com
References: <cover.1475907512.git.eraretuya@gmail.com>
 <9018314d134e3e33f892ad78969e11bf5ffa0950.1475907512.git.eraretuya@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <39a0c2c4-6fcb-21f2-f9b3-ddb360f58c75@metafoo.de>
Date: Sat, 8 Oct 2016 14:21:46 +0200
MIME-Version: 1.0
In-Reply-To: <9018314d134e3e33f892ad78969e11bf5ffa0950.1475907512.git.eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/08/2016 08:50 AM, Eva Rachel Retuya wrote:
> The oversampling ratio is controlled using the oversampling pins,
> OS [2:0] with OS2 being the MSB control bit, and OS0 the LSB control
> bit.
> 
> The gpio connected to the OS2 pin is not being set correctly, only OS0
> and OS1 pins are being set. Fix the typo to allow proper control of the
> oversampling pins.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Fixes: b9618c0 ("staging: IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4")

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Ideally you'd have but the patches in the opposite order, fix first, then
rework. As it is right now with the fix after the rework the fix no longer
applies cleanly to older versions.

> ---
>  drivers/staging/iio/adc/ad7606_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index 437c7d0..2042225 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -183,7 +183,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&indio_dev->mlock);
>  		gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
>  		gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
> -		gpio_set_value(st->pdata->gpio_os1, (ret >> 2) & 1);
> +		gpio_set_value(st->pdata->gpio_os2, (ret >> 2) & 1);
>  		st->oversampling = val;
>  		mutex_unlock(&indio_dev->mlock);
>  		return 0;
> 
